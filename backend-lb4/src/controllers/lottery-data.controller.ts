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
import {LotteryData} from '../models';
import {LotteryDataRepository} from '../repositories';

export class LotteryDataController {
  constructor(
    @repository(LotteryDataRepository)
    public lotteryDataRepository : LotteryDataRepository,
  ) {}

  @post('/lottery-data', {
    responses: {
      '200': {
        description: 'LotteryData model instance',
        content: {'application/json': {schema: getModelSchemaRef(LotteryData)}},
      },
    },
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryData, {
            title: 'NewLotteryData',
            
          }),
        },
      },
    })
    lotteryData: LotteryData,
  ): Promise<LotteryData> {
    return this.lotteryDataRepository.create(lotteryData);
  }

  @get('/lottery-data/count', {
    responses: {
      '200': {
        description: 'LotteryData model count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async count(
    @param.query.object('where', getWhereSchemaFor(LotteryData)) where?: Where<LotteryData>,
  ): Promise<Count> {
    return this.lotteryDataRepository.count(where);
  }

  @get('/lottery-data', {
    responses: {
      '200': {
        description: 'Array of LotteryData model instances',
        content: {
          'application/json': {
            schema: {
              type: 'array',
              items: getModelSchemaRef(LotteryData, {includeRelations: true}),
            },
          },
        },
      },
    },
  })
  async find(
    @param.query.object('filter', getFilterSchemaFor(LotteryData)) filter?: Filter<LotteryData>,
  ): Promise<LotteryData[]> {
    return this.lotteryDataRepository.find(filter);
  }

  @patch('/lottery-data', {
    responses: {
      '200': {
        description: 'LotteryData PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryData, {partial: true}),
        },
      },
    })
    lotteryData: LotteryData,
    @param.query.object('where', getWhereSchemaFor(LotteryData)) where?: Where<LotteryData>,
  ): Promise<Count> {
    return this.lotteryDataRepository.updateAll(lotteryData, where);
  }

  @get('/lottery-data/{id}', {
    responses: {
      '200': {
        description: 'LotteryData model instance',
        content: {
          'application/json': {
            schema: getModelSchemaRef(LotteryData, {includeRelations: true}),
          },
        },
      },
    },
  })
  async findById(
    @param.path.string('id') id: string,
    @param.query.object('filter', getFilterSchemaFor(LotteryData)) filter?: Filter<LotteryData>
  ): Promise<LotteryData> {
    return this.lotteryDataRepository.findById(id, filter);
  }

  @patch('/lottery-data/{id}', {
    responses: {
      '204': {
        description: 'LotteryData PATCH success',
      },
    },
  })
  async updateById(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryData, {partial: true}),
        },
      },
    })
    lotteryData: LotteryData,
  ): Promise<void> {
    await this.lotteryDataRepository.updateById(id, lotteryData);
  }

  @put('/lottery-data/{id}', {
    responses: {
      '204': {
        description: 'LotteryData PUT success',
      },
    },
  })
  async replaceById(
    @param.path.string('id') id: string,
    @requestBody() lotteryData: LotteryData,
  ): Promise<void> {
    await this.lotteryDataRepository.replaceById(id, lotteryData);
  }

  @del('/lottery-data/{id}', {
    responses: {
      '204': {
        description: 'LotteryData DELETE success',
      },
    },
  })
  async deleteById(@param.path.string('id') id: string): Promise<void> {
    await this.lotteryDataRepository.deleteById(id);
  }
}
