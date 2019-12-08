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
import {Trustee} from '../models';
import {TrusteeRepository} from '../repositories';

export class TrusteeController {
  constructor(
    @repository(TrusteeRepository)
    public trusteeRepository : TrusteeRepository,
  ) {}

  @post('/trustees', {
    responses: {
      '200': {
        description: 'Trustee model instance',
        content: {'application/json': {schema: getModelSchemaRef(Trustee)}},
      },
    },
  })
  async create(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Trustee, {
            title: 'NewTrustee',
            exclude: ['id'],
          }),
        },
      },
    })
    trustee: Omit<Trustee, 'id'>,
  ): Promise<Trustee> {
    return this.trusteeRepository.create(trustee);
  }

  @get('/trustees/count', {
    responses: {
      '200': {
        description: 'Trustee model count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async count(
    @param.query.object('where', getWhereSchemaFor(Trustee)) where?: Where<Trustee>,
  ): Promise<Count> {
    return this.trusteeRepository.count(where);
  }

  @get('/trustees', {
    responses: {
      '200': {
        description: 'Array of Trustee model instances',
        content: {
          'application/json': {
            schema: {
              type: 'array',
              items: getModelSchemaRef(Trustee, {includeRelations: true}),
            },
          },
        },
      },
    },
  })
  async find(
    @param.query.object('filter', getFilterSchemaFor(Trustee)) filter?: Filter<Trustee>,
  ): Promise<Trustee[]> {
    return this.trusteeRepository.find(filter);
  }

  @patch('/trustees', {
    responses: {
      '200': {
        description: 'Trustee PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async updateAll(
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Trustee, {partial: true}),
        },
      },
    })
    trustee: Trustee,
    @param.query.object('where', getWhereSchemaFor(Trustee)) where?: Where<Trustee>,
  ): Promise<Count> {
    return this.trusteeRepository.updateAll(trustee, where);
  }

  @get('/trustees/{id}', {
    responses: {
      '200': {
        description: 'Trustee model instance',
        content: {
          'application/json': {
            schema: getModelSchemaRef(Trustee, {includeRelations: true}),
          },
        },
      },
    },
  })
  async findById(
    @param.path.number('id') id: number,
    @param.query.object('filter', getFilterSchemaFor(Trustee)) filter?: Filter<Trustee>
  ): Promise<Trustee> {
    return this.trusteeRepository.findById(id, filter);
  }

  @patch('/trustees/{id}', {
    responses: {
      '204': {
        description: 'Trustee PATCH success',
      },
    },
  })
  async updateById(
    @param.path.number('id') id: number,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Trustee, {partial: true}),
        },
      },
    })
    trustee: Trustee,
  ): Promise<void> {
    await this.trusteeRepository.updateById(id, trustee);
  }

  @put('/trustees/{id}', {
    responses: {
      '204': {
        description: 'Trustee PUT success',
      },
    },
  })
  async replaceById(
    @param.path.number('id') id: number,
    @requestBody() trustee: Trustee,
  ): Promise<void> {
    await this.trusteeRepository.replaceById(id, trustee);
  }

  @del('/trustees/{id}', {
    responses: {
      '204': {
        description: 'Trustee DELETE success',
      },
    },
  })
  async deleteById(@param.path.number('id') id: number): Promise<void> {
    await this.trusteeRepository.deleteById(id);
  }
}
