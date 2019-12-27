import {
  Count,
  CountSchema,
  Filter,
  repository,
  Where,
} from '@loopback/repository';
import {
  del,
  get,
  getModelSchemaRef,
  getWhereSchemaFor,
  param,
  patch,
  post,
  requestBody,
} from '@loopback/rest';
import {
  Device,
  LotteryItem,
} from '../models';
import {DeviceRepository} from '../repositories';

export class DeviceLotteryItemController {
  constructor(
    @repository(DeviceRepository) protected deviceRepository: DeviceRepository,
  ) { }

  @get('/devices/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Array of LotteryItem\'s belonging to Device',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(LotteryItem)},
          },
        },
      },
    },
  })
  async find(
    @param.path.string('id') id: string,
    @param.query.object('filter') filter?: Filter<LotteryItem>,
  ): Promise<LotteryItem[]> {
    return this.deviceRepository.lotteryItems(id).find(filter);
  }

  @post('/devices/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Device model instance',
        content: {'application/json': {schema: getModelSchemaRef(LotteryItem)}},
      },
    },
  })
  async create(
    @param.path.string('id') id: typeof Device.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {
            title: 'NewLotteryItemInDevice',
            exclude: ['id'],
            optional: ['deviceId']
          }),
        },
      },
    }) lotteryItem: Omit<LotteryItem, 'id'>,
  ): Promise<LotteryItem> {
    return this.deviceRepository.lotteryItems(id).create(lotteryItem);
  }

  @patch('/devices/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Device.LotteryItem PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {partial: true}),
        },
      },
    })
    lotteryItem: Partial<LotteryItem>,
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.deviceRepository.lotteryItems(id).patch(lotteryItem, where);
  }

  @del('/devices/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Device.LotteryItem DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.string('id') id: string,
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.deviceRepository.lotteryItems(id).delete(where);
  }
}
