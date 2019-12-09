import {Entity, model, property, belongsTo} from '@loopback/repository';
import {Trustee} from './trustee.model';
import {LotteryData} from './lottery-data.model';

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

  @belongsTo(() => Trustee)
  trusteeId: number;

  @belongsTo(() => LotteryData)
  lotteryDataId: string;

  constructor(data?: Partial<LotteryItem>) {
    super(data);
  }
}

export interface LotteryItemRelations {
  // describe navigational properties here
}

export type LotteryItemWithRelations = LotteryItem & LotteryItemRelations;
