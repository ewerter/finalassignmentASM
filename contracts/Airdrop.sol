pragma solidity ^0.5.2;

interface erc20token {
    function transfer(address _to, uint256 _amount) external returns (bool);
    function balanceOf(address _p) external returns (uint256);
}
contract dapMerkle {
    
    /* variables */
    bytes32 public MerkleRoot;
    erc20token token;
    address payable owner;
   
    string _name;
    string _symbol;
    uint8 _decimals;

    uint256 _totalSupply;
    
    /* storage */
    mapping (address => bool) sent;
    mapping (address => uint256) _balances;
    
    /* events */
    event tokensSent(address indexed from, address indexed to, uint256 amount);
    event rootChanged(bytes32 root);
    //event test(bytes32 test);
    
    /* modifiers */
    modifier onlyOwner(){
        if (msg.sender == owner){
            _;
        }
    }
    constructor (bytes32 _MerkleRoot) public{
        owner = msg.sender;
        
        MerkleRoot = _MerkleRoot;
        
    }
    function leafHash(address leaf) private pure returns(bytes32) {
        return keccak256(abi.encodePacked(uint8(0x00), leaf));
    }

    function nodeHash(bytes32 left, bytes32 right) private pure returns(bytes32) {
        return keccak256(abi.encodePacked(uint8(0x01), left, right));
    }
    function setRoot(bytes32 _changedRoot) external onlyOwner {
        MerkleRoot = _changedRoot;
        emit rootChanged(_changedRoot);
    }
    
    function transfer(address to, uint256 amount) public returns (bool success) {
        if (_balances[msg.sender] < amount) { return false; }

        _balances[msg.sender] -= amount;
        _balances[to] += amount;

       emit tokensSent(msg.sender, to, amount);

        return true;
    }
    
    
    function getTokenBalance(address tokenWallet) public view returns (uint256){
        return _balances[tokenWallet];
    }
    
    function abortAirdrop() onlyOwner external{
        require(token.balanceOf(address(this)) > 0);
        assert(token.transfer(owner, token.balanceOf( address(this) ) ) );
        selfdestruct(owner);
    }
    
    function getTokens(uint256 path, bytes32[] calldata witnesses, address _receiver, uint256 _amount) external returns (bool){
        require (!sent[_receiver]);
        require (_amount > 0);
        
        bytes32 node = leafHash(msg.sender);
        
        for (uint16 i = 0; i < witnesses.length; i++) {
            if ((path & 0x01) == 1) {
                node = nodeHash(witnesses[i], node);
            } else {
                        node = nodeHash(node, witnesses[i]);
                    }
            path /= 2;
}

        require(node == MerkleRoot, "merkle tree not validated");
        
        // Redeem!
        _balances[_receiver] += _amount;
        //_totalSupply += amount;

        //emit tokensSent(0, _receiver, _amount);
    }

    
     
}