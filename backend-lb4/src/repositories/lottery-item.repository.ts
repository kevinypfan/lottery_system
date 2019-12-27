import {DefaultCrudRepository, repository, BelongsToAccessor} from '@loopback/repository';
import {LotteryItem, LotteryItemRelations, Trustee, LotteryData, Store, Device} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject, Getter} from '@loopback/core';
import {TrusteeRepository} from './trustee.repository';
import {LotteryDataRepository} from './lottery-data.repository';
import {StoreRepository} from './store.repository';
import {DeviceRepository} from './device.repository';

export class LotteryItemRepository extends DefaultCrudRepository<
  LotteryItem,
  typeof LotteryItem.prototype.id,
  LotteryItemRelations
> {

  public readonly trustee: BelongsToAccessor<Trustee, typeof LotteryItem.prototype.id>;

  public readonly lotteryData: BelongsToAccessor<LotteryData, typeof LotteryItem.prototype.id>;

  public readonly store: BelongsToAccessor<Store, typeof LotteryItem.prototype.id>;

  public readonly device: BelongsToAccessor<Device, typeof LotteryItem.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource, @repository.getter('TrusteeRepository') protected trusteeRepositoryGetter: Getter<TrusteeRepository>, @repository.getter('LotteryDataRepository') protected lotteryDataRepositoryGetter: Getter<LotteryDataRepository>, @repository.getter('StoreRepository') protected storeRepositoryGetter: Getter<StoreRepository>, @repository.getter('DeviceRepository') protected deviceRepositoryGetter: Getter<DeviceRepository>,
  ) {
    super(LotteryItem, dataSource);
    this.device = this.createBelongsToAccessorFor('device', deviceRepositoryGetter,);
    this.registerInclusionResolver('device', this.device.inclusionResolver);
    this.store = this.createBelongsToAccessorFor('store', storeRepositoryGetter,);
    this.registerInclusionResolver('store', this.store.inclusionResolver);
    this.lotteryData = this.createBelongsToAccessorFor('lotteryData', lotteryDataRepositoryGetter,);
    this.registerInclusionResolver('lotteryData', this.lotteryData.inclusionResolver);
    this.trustee = this.createBelongsToAccessorFor('trustee', trusteeRepositoryGetter,);
    this.registerInclusionResolver('trustee', this.trustee.inclusionResolver);
  }
}
