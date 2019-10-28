// tslint:disable:no-unused-expression
import { join } from 'path';
import { expect } from 'chai';
import * as uuid from 'uuid/v4';
import { MockControllerAdapter } from '@worldsibu/convector-adapter-mock';
import { ClientFactory, ConvectorControllerClient } from '@worldsibu/convector-core';
import 'mocha';

import { Dynsc, DynscController } from '../src';

describe('Dynsc', () => {
  let adapter: MockControllerAdapter;
  let dynscCtrl: ConvectorControllerClient<DynscController>;
  
  before(async () => {
    // Mocks the blockchain execution environment
    adapter = new MockControllerAdapter();
    dynscCtrl = ClientFactory(DynscController, adapter);

    await adapter.init([
      {
        version: '*',
        controller: 'DynscController',
        name: join(__dirname, '..')
      }
    ]);

    adapter.addUser('Test');
  });
  
  it('should create a default model', async () => {
    const modelSample = new Dynsc({
      id: uuid(),
      name: 'Test',
      created: Date.now(),
      modified: Date.now()
    });

    await dynscCtrl.$withUser('Test').create(modelSample);
  
    const justSavedModel = await adapter.getById<Dynsc>(modelSample.id);
  
    expect(justSavedModel.id).to.exist;
  });
});