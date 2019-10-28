// must be run by 'truffle exec <this file>'

module.exports = function(callback) {
	//starts:
	let Web3 = require('web3');			//npm install web3
	let Eth = require('web3-eth');
	let provider = new Web3.providers.HttpProvider("http://localhost:8545")
	let TContract = require('truffle-contract');	//$ npm install truffle-contract
	// require("../contracts/Base.sol")
	let base_contract = TContract(require("../build/contracts/Base.json"));
	let sat_contract = TContract(require("../build/contracts/Satellite.json"));
	let sat_contract1 = TContract(require("../build/contracts/Satellite1.json"));
	let sat_contract2 = TContract(require("../build/contracts/Satellite2.json"));
	// console.log(Object.keys(sat_contract))
	// console.log(sat_contract)
	base_contract.setProvider(provider);
	sat_contract1.setProvider(provider);
	sat_contract2.setProvider(provider);

	async function _f(){
		console.log("[starting]")
		var Tbeg = (new Date).getTime();
		let accounts = await web3.eth.getAccounts()
		web3.eth.defaultAccount = accounts[0];
		// console.log(accounts);

		let base_sc = await base_contract.deployed();
		let sat_sc1 = await sat_contract1.deployed();
		let sat_sc2 = await sat_contract2.deployed();
		// console.log("SCbase: "+await base_sc.address)
		// console.log("SCsat1: "+await sat_contract1.address)
		// console.log("SCsat2: "+await sat_contract2.address)


		// //test (v0):
		
		// // console.log("SC→ sat: "+await base_sc.satelliteAddress())
		// // await base_sc.updateSatelliteAddress(sat_sc1.address, {from: accounts[0]})
		// // await base_sc.setVariable({from: accounts[0]})
		// // console.log("SC→ sat: "+await base_sc.satelliteAddress())

		// console.log( await web3.eth.getBlock(0) );
		// // return;
		// // // console.log( await web3.eth.getBlock(1) );

		// // var block = await web3.eth.getBlock(0);
		// // console.log( typeof(block) );
		// // console.log( block.size );
		// // console.log( await web3.eth.getBlockNumber() );

		// console.log("ARGV: "+process.argv+"    "+process.argv.length)
		// let Ntx = 10;
		let Ntx = process.argv[process.argv.length-1];
		// console.log(Ntx)
		// return 
		let Ctx = 0;
		let N0 = await web3.eth.getBlockNumber();

		// //compute bench (v1):
		// var Tstart = (new Date).getTime();
		// for(let i=0 ; i<Ntx ; i++) {
		// 	//1. update sattelite
		// 	await base_sc.updateSatelliteAddress(sat_sc1.address, {from: accounts[0]});
		// 	//2. compute sattelite
		// 	await base_sc.setVariable({from: accounts[0]});
		// 	//3. get var
		// 	base_sc.variable();
		// 	// console.log(await base_sc.variable())
		// 	// console.log("SC→ sat: "+await base_sc.satelliteAddress())
		// 	//→ again to simulate the change of sattelite
		// 	//4. update sattelite
		// 	await base_sc.updateSatelliteAddress(sat_sc2.address, {from: accounts[0]});
		// 	//5. compute sattelite
		// 	await base_sc.setVariable({from: accounts[0]});
		// 	//6. get var
		// 	base_sc.variable();
		// 	// console.log(await base_sc.variable())
		// 	// console.log("SC→ sat: "+await base_sc.satelliteAddress())
		// }
		// var Tdiff = Math.round( ((new Date).getTime() - Tstart) / 1000 );
		// // end bench

		//compute bench (v2):
		let promises = [];
		var Tstart = (new Date).getTime();
		for(let i=0 ; i<Math.round(Ntx/2) ; i++) {
			//1. update sattelite
			promises.push(base_sc.updateSatelliteAddress(sat_sc1.address, {from: accounts[0]}));
			//2. compute sattelite
			promises.push(await base_sc.setVariable({from: accounts[0]}));
			//3. get var
			promises.push(base_sc.variable());
			//→ again to simulate the change of sattelite
			//4. update sattelite
			promises.push(base_sc.updateSatelliteAddress(sat_sc2.address, {from: accounts[0]}));
			//5. compute sattelite
			promises.push(base_sc.setVariable({from: accounts[0]}));
			//6. get var
			promises.push(base_sc.variable());
			Ctx += 6;
		}
		await Promise.all(promises);
		var Tdiff = Math.round( ((new Date).getTime() - Tstart) / 1000 );
		//end bench

		//blocks size:
		let N = await web3.eth.getBlockNumber() - N0;
		let sumbsizes = 0;
		for(var i=N0 ; i<N+N0 ; i++) {
			var block = await web3.eth.getBlock(i);
			// bsizes.push(block.size)
			sumbsizes += block.size;
		}
		let avg_bsize = Math.round(sumbsizes/N);

		var T = Math.round( ((new Date).getTime() - Tbeg) / 1000 );
		console.log("----------------------------------------------------");
		console.log("[IN]");
		console.log("Nb tx: "+Ntx);
		console.log("----------------------------------------------------");
		console.log("[OUT]");
		console.log("Nb Block: "+N);
		console.log("Avg tx / Block: "+(Ntx/N));
		console.log("Bsize: "+avg_bsize);
		console.log("Nb tx: "+Ctx);
		console.log("Time spent (s): "+Tdiff);
		console.log("Time spent (min): "+Math.round(Tdiff/60));
		console.log("----------------------------------------------------");
		console.log("Total time spent (s): "+T);
		console.log("----------------------------------------------------");
		return ";__;"+Ntx+";"+N+";"+Ctx+";"+Tdiff+";"+(Math.round(Tdiff/6)/10)+";"+avg_bsize+";"+T+"";
	}
	_f().then(r => {
		// console.log(r);
		console.error(r);
		console.log("[ending]");

		//returns:
		callback();
	}).catch(err => {
		console.log("Err: "+String(err));
		console.log("[ending]");

		//returns:
		callback();
	});
}
