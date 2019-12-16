import {Entity, model, property, belongsTo} from '@loopback/repository';
import {Store} from './store.model';

@model()
export class Device extends Entity {
  @property({
    type: 'string',
    id: true,
    generated: false,
    required: true,
  })
  id: string;

  @property({
    type: 'string',
  })
  name?: string;

  @property({
    type: 'boolean',
    default: false,
  })
  isVerify: boolean;

  @property({
    type: 'string',
  })
  model?: string;

  @property({
    type: 'string',
  })
  version?: string;

  @belongsTo(() => Store)
  storeId: string;

  constructor(data?: Partial<Device>) {
    super(data);
  }
}

export interface DeviceRelations {
  // describe navigational properties here
}

export type DeviceWithRelations = Device & DeviceRelations;
