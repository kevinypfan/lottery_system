import {Entity, model, property} from '@loopback/repository';

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


  constructor(data?: Partial<LotteryItem>) {
    super(data);
  }
}

export interface LotteryItemRelations {
  // describe navigational properties here
}

export type LotteryItemWithRelations = LotteryItem & LotteryItemRelations;
