import {DefaultCrudRepository, repository, BelongsToAccessor, HasManyRepositoryFactory} from '@loopback/repository';
import {Device, DeviceRelations, Store, LotteryItem} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject, Getter} from '@loopback/core';
import {StoreRepository} from './store.repository';
import {LotteryItemRepository} from './lottery-item.repository';

export class DeviceRepository extends DefaultCrudRepository<
  Device,
  typeof Device.prototype.id,
  DeviceRelations
> {

  public readonly store: BelongsToAccessor<Store, typeof Device.prototype.id>;

  public readonly lotteryItems: HasManyRepositoryFactory<LotteryItem, typeof Device.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource, @repository.getter('StoreRepository') protected storeRepositoryGetter: Getter<StoreRepository>, @repository.getter('LotteryItemRepository') protected lotteryItemRepositoryGetter: Getter<LotteryItemRepository>,
  ) {
    super(Device, dataSource);
    this.lotteryItems = this.createHasManyRepositoryFactoryFor('lotteryItems', lotteryItemRepositoryGetter,);
    this.registerInclusionResolver('lotteryItems', this.lotteryItems.inclusionResolver);
    this.store = this.createBelongsToAccessorFor('store', storeRepositoryGetter,);
    this.registerInclusionResolver('store', this.store.inclusionResolver);
  }
}
