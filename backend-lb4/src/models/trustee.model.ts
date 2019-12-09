import {Entity, model, property, hasMany} from '@loopback/repository';
import {LotteryItem} from './lottery-item.model';

@model()
export class Trustee extends Entity {
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
  name: string;

  @property({
    type: 'string',
    required: true,
    index: {
      unique: true,
    },
  })
  card_code: string;

  @property({
    type: 'string',
  })
  bank?: string;

  @property({
    type: 'string',
  })
  store?: string;

  @property({
    type: 'string',
  })
  identity?: string;

  @property({
    type: 'date',
  })
  birthday?: string;

  @property({
    type: 'string',
  })
  hex?: string;

  @property({
    type: 'string',
  })
  phone?: string;

  @property({
    type: 'string',
  })
  consignee_1?: string;

  @property({
    type: 'string',
  })
  consignee_2?: string;

  @hasMany(() => LotteryItem)
  lotteryItems: LotteryItem[];

  constructor(data?: Partial<Trustee>) {
    super(data);
  }
}

export interface TrusteeRelations {
  // describe navigational properties here
}

export type TrusteeWithRelations = Trustee & TrusteeRelations;
