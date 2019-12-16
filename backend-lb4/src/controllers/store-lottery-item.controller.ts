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
  Store,
  LotteryItem,
} from '../models';
import {StoreRepository} from '../repositories';

export class StoreLotteryItemController {
  constructor(
    @repository(StoreRepository) protected storeRepository: StoreRepository,
  ) { }

  @get('/stores/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Array of LotteryItem\'s belonging to Store',
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
    return this.storeRepository.lotteryItems(id).find(filter);
  }

  @post('/stores/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Store model instance',
        content: {'application/json': {schema: getModelSchemaRef(LotteryItem)}},
      },
    },
  })
  async create(
    @param.path.string('id') id: typeof Store.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {
            title: 'NewLotteryItemInStore',
            exclude: ['id'],
            optional: ['storeId']
          }),
        },
      },
    }) lotteryItem: Omit<LotteryItem, 'id'>,
  ): Promise<LotteryItem> {
    return this.storeRepository.lotteryItems(id).create(lotteryItem);
  }

  @patch('/stores/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Store.LotteryItem PATCH success count',
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
    return this.storeRepository.lotteryItems(id).patch(lotteryItem, where);
  }

  @del('/stores/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Store.LotteryItem DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.string('id') id: string,
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.storeRepository.lotteryItems(id).delete(where);
  }
}
