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
  Device,
} from '../models';
import {LotteryItemRepository} from '../repositories';

export class LotteryItemDeviceController {
  constructor(
    @repository(LotteryItemRepository)
    public lotteryItemRepository: LotteryItemRepository,
  ) { }

  @get('/lottery-items/{id}/device', {
    responses: {
      '200': {
        description: 'Device belonging to LotteryItem',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Device)},
          },
        },
      },
    },
  })
  async getDevice(
    @param.path.number('id') id: typeof LotteryItem.prototype.id,
  ): Promise<Device> {
    return this.lotteryItemRepository.device(id);
  }
}
