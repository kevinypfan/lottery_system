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
  Store,
} from '../models';
import {LotteryItemRepository} from '../repositories';

export class LotteryItemStoreController {
  constructor(
    @repository(LotteryItemRepository)
    public lotteryItemRepository: LotteryItemRepository,
  ) { }

  @get('/lottery-items/{id}/store', {
    responses: {
      '200': {
        description: 'Store belonging to LotteryItem',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Store)},
          },
        },
      },
    },
  })
  async getStore(
    @param.path.number('id') id: typeof LotteryItem.prototype.id,
  ): Promise<Store> {
    return this.lotteryItemRepository.store(id);
  }
}
