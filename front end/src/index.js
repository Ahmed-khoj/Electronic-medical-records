import Web3 from "web3";
import metaCoinArtifact from "../../build/contracts/EMR.json";

const App = {
  web3: null,
  account: null,
  meta: null,

  start: async function() {
    const { web3 } = this;

    try {
      // get contract instance
      const networkId = await web3.eth.net.getId();
      const deployedNetwork = metaCoinArtifact.networks[networkId];
      this.meta = new web3.eth.Contract(
        metaCoinArtifact.abi,
        deployedNetwork.address,
      );

      // get accounts
      const accounts = await web3.eth.getAccounts();
      this.account = accounts[0];

      //this.refreshBalance();
    } catch (error) {
      console.error("Could not connect to contract or chain.");
    }
  },

  addpatient: async function() {
    const { addpatient } = this.meta.methods;
    const PId = parseInt(document.getElementById("PId").value);
    const PName = document.getElementById("PName").value;
    const PAge = parseInt(document.getElementById("PAge").value);
    const PGender = document.getElementById("PGender").value;
    const PAddress = document.getElementById("PAddress").value;
    const VisitRea = document.getElementById("VisitRea").value;

    await addpatient(PId, PName, PAge,PGender,PAddress,VisitRea).send({ from: this.account });
    this.setStatus("Success!! The information has been stored in blockchain ");
  },
  fatch: async function (){
    const { fatch } = this.meta.methods;
    const id = parseInt(document.getElementById("id").value);
    await fatch(id).call().then(function(res){
      console.log(res)
    });
    
  },

  setStatus: function(message) {
    const status = document.getElementById("status");
    status.innerHTML = message;
  },
};
window.App = App;
window.addEventListener("load", function() {
  if (window.ethereum) {
    // use MetaMask's provider
    App.web3 = new Web3(window.ethereum);
    window.ethereum.enable(); // get permission to access accounts
  } else {
    console.warn(
      "No web3 detected. Falling back to http://127.0.0.1:7545. You should remove this fallback when you deploy live",
    );
    // fallback - use your fallback strategy (local node / hosted node + in-dapp id mgmt / fail)
    App.web3 = new Web3(
      new Web3.providers.HttpProvider("HTTP://127.0.0.1:7545"),
    );
  }

  App.start();
});
