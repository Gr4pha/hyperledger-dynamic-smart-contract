pragma solidity ^0.5.11;

contract TestAccessCtrl {

    address public owner = msg.sender;
    uint public dyn_cst = 123;
    
    modifier only_by(address _account) {
        require(msg.sender == _account);
        _;
    }
    
    function set_dyn_cst(uint _new_cst) public only_by(owner) {
        dyn_cst = _new_cst;
    }
    
    function do_something(address _newOwner) public {
        //do something using the dynamic constant 'dyn_cst' to adapt the function behavior
    }

}

