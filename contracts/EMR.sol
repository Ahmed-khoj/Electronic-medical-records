// SPDX-License-Identifier: GPL-3.0
pragma solidity  >=0.4.0 <0.9.0;



contract ERC20 {
    mapping (address => uint256) public _balances;
    mapping (address => mapping (address => uint256)) public _allowances;
    uint256 public _totalSupply;



        function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }

    
    function balanceOf(address account) public view returns (uint256) {
        return _balances[account];
    }

      function allowance(address owner, address spender) public view returns (uint256) {
        return _allowances[owner][spender];
    }

    function _mint(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: mint to the zero address");

        _totalSupply += amount;
        _balances[account] += amount;
    }

     function _burn(address account, uint256 amount) internal {
        require(account != address(0), "ERC20: burn from the zero address");
        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        _balances[account] = accountBalance - amount;
        _totalSupply -= amount;
    }

 

}

library SafeMath {
  
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

   
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
       
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        // Solidity only automatically asserts when dividing by 0
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

contract myToken is ERC20 {

    string public constant name = "myToken"; 
    string public constant  symbol = "TKN";
    uint8 public constant decimals = 18;  


  uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));

  mapping(address => uint256) balances;

  mapping(address => mapping (address => uint256)) allowed;

  uint256 totalSupply_;

  using SafeMath for uint256;
}

contract EMR is ERC20 {
    myToken public mytoken;
    address public Owner;
    uint256 counter;// increasment
    uint256 public tokenRewardAmount;

     struct Patient {
        uint256 PId;
        string PName;
        uint256 PAge;
        string PGender;
        string PAddress;
        string VisitRea;
    }
    event PatientLoaded(uint256 PId,string PName,uint256 PAge,string PGender,string PAddress,string VisitRea);
    mapping(uint=> Patient)public PatientNO;

modifier OnlyOwner (){
        require( Owner == msg.sender, "you are not the owner");
        _;
    }
modifier higherThanZero(uint256 _uint) {
        require(_uint > 0);
        _;
    }

  /**
   * Add a Patient record.
   * Returns the Patient number of the medical record.
   * this function takes 6 args to input values to the struct Patient
   */
    
    function addpatient(uint256 _PId,string memory _PName, uint256 _PAge, string memory _PGender,string memory _PAddress,string memory _VisitRea) public{
    counter++;
    PatientNO[counter] = Patient(_PId, _PName,_PAge, _PGender, _PAddress,_VisitRea);
    _mint(msg.sender, counter);
    emit PatientLoaded(_PId, _PName,_PAge, _PGender, _PAddress,_VisitRea);

    }
  /**
   * Get all medical records of a Patient.
   */
    function fatch(uint _PatientNO) public view returns(uint256 PId,string memory PName, uint256 PAge, string memory PGender,string memory PAddress,string memory VisitRea){
        PId = PatientNO[_PatientNO].PId;
        PName = PatientNO[_PatientNO].PName;
        PAge = PatientNO[_PatientNO].PAge;
        PGender = PatientNO[_PatientNO].PGender;
        PAddress = PatientNO[_PatientNO].PAddress;
        VisitRea = PatientNO[_PatientNO].VisitRea;

        
    }
   
 

  /**
   * A user can specify, which hospitals are allowed to view their medical records.
   * Access is granted, when the user adds his address to a doctors list of patients.
   * As soon as the user address is removed from the list, access for the doctor is revoked.
   *
   * mapping: doctorsAddress -> patientsAddresses
   */
  mapping (address => address[]) public doctorsPermissions;
  mapping (address => address[]) public insurancePermissions;

  /**
   * Allow a doctor/insurance to view all your documents.
   */
  function giveAccessToDoctor(address doctor) public {
    doctorsPermissions[doctor].push(msg.sender);
  }
 
 function giveAccessToIns(address insurance) public {
   insurancePermissions[insurance].push(msg.sender);
  }
  
  /**
   * Revoke access to your documents.
   */
   
  function revokeAccessFromDoctor(address doctor, uint _recordIndex) public {
    require(doctorsPermissions[doctor][_recordIndex] == msg.sender, 'You can only revoke access to your own documents.');
    delete doctorsPermissions[doctor][_recordIndex];
  }
  
   function revokeAccessFromIns(address insurance,  uint _recordIndex) public {
    require(insurancePermissions[insurance][ _recordIndex] == msg.sender, 'You can only revoke access to your own documents.');
    delete insurancePermissions[insurance][ _recordIndex];
  }

  /**
   * Returns all the patients addresses that gave the doctor access.
   */
  function getDoctorsPermissions(address doctor) public view returns (address[] memory) {
    return doctorsPermissions[doctor];
  }

  function setmyTokenReward(uint256 _tokenReward) private OnlyOwner higherThanZero(_tokenReward)
    {
        tokenRewardAmount = _tokenReward;
        
    
    }

    function payPatient(uint256 _tokenReward) public OnlyOwner higherThanZero(_tokenReward) {
            tokenRewardAmount = _tokenReward;
            require (tokenRewardAmount == _tokenReward);
            _mint(msg.sender, _tokenReward);

    }

}