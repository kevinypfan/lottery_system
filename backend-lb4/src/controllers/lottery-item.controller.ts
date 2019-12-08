import {
  Count,
  CountSchema,
  Filter,
  repository,
  Where,
} from '@loopback/repository';
import {
  post,
  param,
  get,
  getFilterSchemaFor,
  getModelSchemaRef,
  getWhereSchemaFor,
  patch,
  put,
  del,
  requestBody,
} from '@loopback/rest';
import {LotteryItem} from '../models';
import {LotteryItemRepository} from '../repositories';

export class LotteryItemController {
  constructor(
    @repository(LotteryItemRepository)
    public lotteryItemRepository : LotteryItemRepository,
  ) {}

  @post('/lottery-items', {
    responses: {
      '200': {
        description: 'LotteryItem model instance',
        content: {'application/json': {schema: getModelSchemaRef(LotteryItem)}},
      },
    },
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {
            title: 'NewLotteryItem',
            exclude: ['id'],
          }),
        },
      },
    })
    lotteryItem: Omit<LotteryItem, 'id'>,
  ): Promise<LotteryItem> {
    return this.lotteryItemRepository.create(lotteryItem);
  }

  @get('/lottery-items/count', {
    responses: {
      '200': {
        description: 'LotteryItem model count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async count(
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.lotteryItemRepository.count(where);
  }

  @get('/lottery-items', {
    responses: {
      '200': {
        description: 'Array of LotteryItem model instances',
        content: {
          'application/json': {
            schema: {
              type: 'array',
              items: getModelSchemaRef(LotteryItem, {includeRelations: true}),
            },
          },
        },
      },
    },
  })
  async find(
    @param.query.object('filter', getFilterSchemaFor(LotteryItem)) filter?: Filter<LotteryItem>,
  ): Promise<LotteryItem[]> {
    return this.lotteryItemRepository.find(filter);
  }

  @patch('/lottery-items', {
    responses: {
      '200': {
        description: 'LotteryItem PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {partial: true}),
        },
      },
    })
    lotteryItem: LotteryItem,
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.lotteryItemRepository.updateAll(lotteryItem, where);
  }

  @get('/lottery-items/{id}', {
    responses: {
      '200': {
        description: 'LotteryItem model instance',
        content: {
          'application/json': {
            schema: getModelSchemaRef(LotteryItem, {includeRelations: true}),
          },
        },
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.query.object('filter', getFilterSchemaFor(LotteryItem)) filter?: Filter<LotteryItem>
  ): Promise<LotteryItem> {
    return this.lotteryItemRepository.findById(id, filter);
  }

  @patch('/lottery-items/{id}', {
    responses: {
      '204': {
        description: 'LotteryItem PATCH success',
      },
    },
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {partial: true}),
        },
      },
    })
    lotteryItem: LotteryItem,
  ): Promise<void> {
    await this.lotteryItemRepository.updateById(id, lotteryItem);
  }

  @put('/lottery-items/{id}', {
    responses: {
      '204': {
        description: 'LotteryItem PUT success',
      },
    },
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() lotteryItem: LotteryItem,
  ): Promise<void> {
    await this.lotteryItemRepository.replaceById(id, lotteryItem);
  }

  @del('/lottery-items/{id}', {
    responses: {
      '204': {
        description: 'LotteryItem DELETE success',
      },
    },
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.lotteryItemRepository.deleteById(id);
  }
}
