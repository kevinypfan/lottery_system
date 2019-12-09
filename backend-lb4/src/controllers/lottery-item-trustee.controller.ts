import {
  repository,
} from '@loopback/repository';
import {
  param,
  get,
  getModelSchemaRef,
} from '@loopback/rest';
import {
  LotteryItem,
  Trustee,
} from '../models';
import {LotteryItemRepository} from '../repositories';

export class LotteryItemTrusteeController {
  constructor(
    @repository(LotteryItemRepository)
    public lotteryItemRepository: LotteryItemRepository,
  ) { }

  @get('/lottery-items/{id}/trustee', {
    responses: {
      '200': {
        description: 'Trustee belonging to LotteryItem',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Trustee)},
          },
        },
      },
    },
  })
  async getTrustee(
    @param.path.number('id') id: typeof LotteryItem.prototype.id,
  ): Promise<Trustee> {
    return this.lotteryItemRepository.trustee(id);
  }
}
