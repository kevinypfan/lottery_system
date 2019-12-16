import {DefaultCrudRepository, repository, BelongsToAccessor} from '@loopback/repository';
import {Device, DeviceRelations, Store} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject, Getter} from '@loopback/core';
import {StoreRepository} from './store.repository';

export class DeviceRepository extends DefaultCrudRepository<
  Device,
  typeof Device.prototype.id,
  DeviceRelations
> {

  public readonly store: BelongsToAccessor<Store, typeof Device.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource, @repository.getter('StoreRepository') protected storeRepositoryGetter: Getter<StoreRepository>,
  ) {
    super(Device, dataSource);
    this.store = this.createBelongsToAccessorFor('store', storeRepositoryGetter,);
    this.registerInclusionResolver('store', this.store.inclusionResolver);
  }
}
