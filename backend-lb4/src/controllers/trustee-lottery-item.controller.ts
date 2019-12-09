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
  Trustee,
  LotteryItem,
} from '../models';
import {TrusteeRepository} from '../repositories';

export class TrusteeLotteryItemController {
  constructor(
    @repository(TrusteeRepository) protected trusteeRepository: TrusteeRepository,
  ) { }

  @get('/trustees/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Array of LotteryItem\'s belonging to Trustee',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(LotteryItem)},
          },
        },
      },
    },
  })
  async find(
    @param.path.number('id') id: number,
    @param.query.object('filter') filter?: Filter<LotteryItem>,
  ): Promise<LotteryItem[]> {
    return this.trusteeRepository.lotteryItems(id).find(filter);
  }

  @post('/trustees/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Trustee model instance',
        content: {'application/json': {schema: getModelSchemaRef(LotteryItem)}},
      },
    },
  })
  async create(
    @param.path.number('id') id: typeof Trustee.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(LotteryItem, {
            title: 'NewLotteryItemInTrustee',
            exclude: ['id'],
            optional: ['trusteeId']
          }),
        },
      },
    }) lotteryItem: Omit<LotteryItem, 'id'>,
  ): Promise<LotteryItem> {
    return this.trusteeRepository.lotteryItems(id).create(lotteryItem);
  }

  @patch('/trustees/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Trustee.LotteryItem PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.number('id') id: number,
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
    return this.trusteeRepository.lotteryItems(id).patch(lotteryItem, where);
  }

  @del('/trustees/{id}/lottery-items', {
    responses: {
      '200': {
        description: 'Trustee.LotteryItem DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.number('id') id: number,
    @param.query.object('where', getWhereSchemaFor(LotteryItem)) where?: Where<LotteryItem>,
  ): Promise<Count> {
    return this.trusteeRepository.lotteryItems(id).delete(where);
  }
}
