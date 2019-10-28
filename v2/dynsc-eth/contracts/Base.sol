pragma solidity >=0.4.21 <0.6.0;

import "./Satellite.sol";

contract Base {
    uint public variable;
    // address satelliteAddress;
    address public satelliteAddress;
    
	constructor() public {
	}
    
    function setVariable() public {
        Satellite s = Satellite(satelliteAddress);
        variable = s.calculateVariable();
    }
    
    function updateSatelliteAddress(address _address) public {
        satelliteAddress = _address;
    }
}

