//Hyperledger Fabric 1.4.1, NodeJS
'use strict';

const { Contract } = require('fabric-contract-api');
const { ClientIdentity } = require('fabric-shim');


class TestAccessCtrl extends Contract {

	async Set(ctx) {
		let cid = new ClientIdentity(ctx.stub);
		//attributes must be given and embedded into the certificate of the identity at registering by the Certification Authority
		if (cid.assertAttributeValue('attribute_name', 'attribute_value')){
			throw new Error('Not an authorized user');
		}
		//updating the DynCst value
		let dyn_cst = await ctx.stub.getState(ctx.name);
		dyn_cst.value = ctx.newValue;
        await ctx.stub.putState(ctx.name, dyn_cst);
	}

}
