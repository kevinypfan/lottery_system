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
  LotteryData,
} from '../models';
import {LotteryItemRepository} from '../repositories';

export class LotteryItemLotteryDataController {
  constructor(
    @repository(LotteryItemRepository)
    public lotteryItemRepository: LotteryItemRepository,
  ) { }

  @get('/lottery-items/{id}/lottery-data', {
    responses: {
      '200': {
        description: 'LotteryData belonging to LotteryItem',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(LotteryData)},
          },
        },
      },
    },
  })
  async getLotteryData(
    @param.path.number('id') id: typeof LotteryItem.prototype.id,
  ): Promise<LotteryData> {
    return this.lotteryItemRepository.lotteryData(id);
  }
}
