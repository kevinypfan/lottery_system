import {DefaultCrudRepository, repository, HasManyRepositoryFactory} from '@loopback/repository';
import {Store, StoreRelations, LotteryItem, Device} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject, Getter} from '@loopback/core';
import {LotteryItemRepository} from './lottery-item.repository';
import {DeviceRepository} from './device.repository';

export class StoreRepository extends DefaultCrudRepository<
  Store,
  typeof Store.prototype.id,
  StoreRelations
> {

  public readonly lotteryItems: HasManyRepositoryFactory<LotteryItem, typeof Store.prototype.id>;

  public readonly devices: HasManyRepositoryFactory<Device, typeof Store.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource, @repository.getter('LotteryItemRepository') protected lotteryItemRepositoryGetter: Getter<LotteryItemRepository>, @repository.getter('DeviceRepository') protected deviceRepositoryGetter: Getter<DeviceRepository>,
  ) {
    super(Store, dataSource);
    this.devices = this.createHasManyRepositoryFactoryFor('devices', deviceRepositoryGetter,);
    this.registerInclusionResolver('devices', this.devices.inclusionResolver);
    this.lotteryItems = this.createHasManyRepositoryFactoryFor('lotteryItems', lotteryItemRepositoryGetter,);
    this.registerInclusionResolver('lotteryItems', this.lotteryItems.inclusionResolver);
  }
}
