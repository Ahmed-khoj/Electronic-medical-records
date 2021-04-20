const EMR = artifacts.require("EMR");



contract("EMR", async function(accounts){

    it(
        "should add a record", async function(){
            let instance = await EMR.deployed()
            await instance.addpatient(1, "ahmed", 22, "male","makkah", "flu"), {from: accounts[0]};
    })},

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
    