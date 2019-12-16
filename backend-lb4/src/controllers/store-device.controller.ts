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
  Device,
} from '../models';
import {StoreRepository} from '../repositories';

export class StoreDeviceController {
  constructor(
    @repository(StoreRepository) protected storeRepository: StoreRepository,
  ) { }

  @get('/stores/{id}/devices', {
    responses: {
      '200': {
        description: 'Array of Device\'s belonging to Store',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Device)},
          },
        },
      },
    },
  })
  async find(
    @param.path.string('id') id: string,
    @param.query.object('filter') filter?: Filter<Device>,
  ): Promise<Device[]> {
    return this.storeRepository.devices(id).find(filter);
  }

  @post('/stores/{id}/devices', {
    responses: {
      '200': {
        description: 'Store model instance',
        content: {'application/json': {schema: getModelSchemaRef(Device)}},
      },
    },
  })
  async create(
    @param.path.string('id') id: typeof Store.prototype.id,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Device, {
            title: 'NewDeviceInStore',
            exclude: ['id'],
            optional: ['storeId']
          }),
        },
      },
    }) device: Omit<Device, 'id'>,
  ): Promise<Device> {
    return this.storeRepository.devices(id).create(device);
  }

  @patch('/stores/{id}/devices', {
    responses: {
      '200': {
        description: 'Store.Device PATCH success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async patch(
    @param.path.string('id') id: string,
    @requestBody({
      content: {
        'application/json': {
          schema: getModelSchemaRef(Device, {partial: true}),
        },
      },
    })
    device: Partial<Device>,
    @param.query.object('where', getWhereSchemaFor(Device)) where?: Where<Device>,
  ): Promise<Count> {
    return this.storeRepository.devices(id).patch(device, where);
  }

  @del('/stores/{id}/devices', {
    responses: {
      '200': {
        description: 'Store.Device DELETE success count',
        content: {'application/json': {schema: CountSchema}},
      },
    },
  })
  async delete(
    @param.path.string('id') id: string,
    @param.query.object('where', getWhereSchemaFor(Device)) where?: Where<Device>,
  ): Promise<Count> {
    return this.storeRepository.devices(id).delete(where);
  }
}
