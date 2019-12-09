import {Entity, model, property} from '@loopback/repository';

@model()
export class LotteryData extends Entity {
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
  image_url?: string;

  @property({
    type: 'number',
  })
  price?: number;

  @property({
    type: 'number',
  })
  max_bonus?: number;

  @property({
    type: 'date',
  })
  start_sell?: string;

  @property({
    type: 'date',
  })
  stop_sell?: string;

  @property({
    type: 'date',
  })
  last_redeem?: string;

  @property({
    type: 'number',
  })
  max_issue?: number;

  @property({
    type: 'number',
  })
  max_top?: number;

  @property({
    type: 'string',
  })
  sales_rate?: string;

  @property({
    type: 'number',
  })
  unredeemed?: number;

  constructor(data?: Partial<LotteryData>) {
    super(data);
  }
}

export interface LotteryDataRelations {
  // describe navigational properties here
}

export type LotteryDataWithRelations = LotteryData & LotteryDataRelations;
