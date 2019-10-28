import { ChaincodeTx } from '@worldsibu/convector-platform-fabric';
import * as yup from 'yup';
import {
  Controller,
  ConvectorController,
  Invokable,
  Param
} from '@worldsibu/convector-core';

import { Dynsc } from './dynsc.model';

@Controller('dynsc')
export class DynscController extends ConvectorController<ChaincodeTx> {
  @Invokable()
  public async create(
    @Param(yup.string())
    name: string
  ) {
    let dynsc = new Dynsc(name);
    await dynsc.save();
    return true;
  }

  @Invokable()
  public async set(
    @Param(yup.string())
    name: string,
    @Param(yup.number())
    cst: number
  ) {
    let dynsc = await Dynsc.getOne(name);
    if (dynsc && dynsc.id) {
      dynsc.value = cst;
      await dynsc.save();
      return true;
    }
    throw new Error('Object does not exist with name='+dynsc.id);
  }

  @Invokable()
  public async get(
    @Param(yup.string())
    name: string
  ) {
    let dynsc = await Dynsc.getOne(name);
    if (dynsc && dynsc.id) {
      return dynsc.value;
    }
    throw new Error('Object does not exist with name='+dynsc.id);
  }

  @Invokable()
  public async do_something_according_to_the_constant() {
    throw Error("Not implemented");
  }
}
