import {Entity, model, property, hasMany} from '@loopback/repository';
import {LotteryItem} from './lottery-item.model';
import {Device} from './device.model';

@model()
export class Store extends Entity {
  @property({
    type: 'string',
    id: true,
    generated: false,
    required: true,
  })
  id: string;

  @property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'string',
  })
  address?: string;

  @property({
    type: 'string',
  })
  tel?: string;

  @property({
    type: 'string',
  })
  phone?: string;

  @hasMany(() => LotteryItem)
  lotteryItems: LotteryItem[];

  @hasMany(() => Device)
  devices: Device[];

  constructor(data?: Partial<Store>) {
    super(data);
  }
}

export interface StoreRelations {
  // describe navigational properties here
}

export type StoreWithRelations = Store & StoreRelations;
