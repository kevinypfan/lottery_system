import {
  repository,
} from '@loopback/repository';
import {
  param,
  get,
  getModelSchemaRef,
} from '@loopback/rest';
import {
  Device,
  Store,
} from '../models';
import {DeviceRepository} from '../repositories';

export class DeviceStoreController {
  constructor(
    @repository(DeviceRepository)
    public deviceRepository: DeviceRepository,
  ) { }

  @get('/devices/{id}/store', {
    responses: {
      '200': {
        description: 'Store belonging to Device',
        content: {
          'application/json': {
            schema: {type: 'array', items: getModelSchemaRef(Store)},
          },
        },
      },
    },
  })
  async getStore(
    @param.path.string('id') id: typeof Device.prototype.id,
  ): Promise<Store> {
    return this.deviceRepository.store(id);
  }
}
