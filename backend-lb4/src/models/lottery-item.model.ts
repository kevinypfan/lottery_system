import {Entity, model, property, belongsTo} from '@loopback/repository';
import {Trustee} from './trustee.model';
import {LotteryData} from './lottery-data.model';
import {Store} from './store.model';

@model()
export class LotteryItem extends Entity {
  @property({
    type: 'number',
    id: true,
    generated: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  number: string;

  @property({
    type: 'boolean',
    required: true,
    default: false,
  })
  revoked: boolean;

  @property({
    type: 'date',
  })
  createdAt: string;

  @property({
    type: 'date',
  })
  exportedAt: string;

  @property({
    type: 'string',
    required: true,
    index: {
      unique: true,
    },
  })
  serial: string;

  @belongsTo(() => Trustee)
  trusteeId: number;

  @belongsTo(() => LotteryData)
  lotteryDataId: string;

  @belongsTo(() => Store)
  storeId: string;

  constructor(data?: Partial<LotteryItem>) {
    super(data);
  }
}

export interface LotteryItemRelations {
  // describe navigational properties here
}

export type LotteryItemWithRelations = LotteryItem & LotteryItemRelations;
