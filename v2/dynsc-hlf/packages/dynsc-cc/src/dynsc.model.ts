import * as yup from 'yup';
import {
  ConvectorModel,
  Default,
  ReadOnly,
  Required,
  Validate
} from '@worldsibu/convector-core-model';

export class Dynsc extends ConvectorModel<Dynsc> {
  @ReadOnly()
  @Required()
  public readonly type = 'io.worldsibu.dynsc';

  @Default(0)
  @Validate(yup.number())
  public value: number;
}
