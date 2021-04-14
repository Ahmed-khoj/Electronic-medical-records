const EMR = artifacts.require("EMR");



contract("EMR", async function(accounts){

    it(
        "should add a record", async function(){
            let instance = await EMR.deployed()
            await instance.addDocument("ahmed", "0x872a2c84021F9acbb586C30198a64e9C79723A94", "0x44Fca8abA3672D3aCeF0425378678B83064CCF26", "2020", "2021", "flu"), {from: accounts[0]};
    })},

    it(
        "should get document", async function(){
            let instance = await EMR.deployed()
            await instance.getDocuments("0x872a2c84021F9acbb586C30198a64e9C79723A94");
    }),

    it(
        "should give access", async function(){
            let instance = await EMR.deployed()
            await instance.giveAccessToDoctor("0x44Fca8abA3672D3aCeF0425378678B83064CCF26");
    }),

    it(
        "should give access", async function(){
            let instance = await EMR.deployed()
            await instance.giveAccessToIns("0x44Fca8abA3672D3aCeF0425378678B83064CCF26");
    }));