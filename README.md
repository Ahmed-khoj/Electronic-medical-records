# Electronic-medical-records
!!!!This is a proof-of-concept project and was designed for testing and educational purposes!!!!



A blockchain-based medical record smart contract on Ethereum.



The smart contract should give patients the ability to add records, give permissions, and revoke permissions.




The front end gives patients, hospitals, and insurance companies the ability to excute functions such as adding records, asking for patient's permission, and accessing records.




This project was built with Truffle and zeppelin-solidity.




Clone
Clone repo:

git clone git@github.com:NFhbar/Ethereum-Medical-Records.git
Create a new .env file in root directory and add your private key:

RINKEBY_PRIVATE_KEY="MyPrivateKeyHere..."
ROPSTEN_PRIVATE_KEY="MyPrivateKeyHere..."
If you don't have a private key, you can use one provided by Ganache (for development only!):

RINKEBY_PRIVATE_KEY="c87509a1c067bbde78beb793e6fa76530b6382a4c0241e5e4a9ec0a0f44dc0d3"
then:

npm install
To enter Truffle:

truffle develop
To compile:

truffle(develop)> compile
To migrate:

truffle(develop)> migrate
To test:

truffle(develop)> test
or

npm run test



