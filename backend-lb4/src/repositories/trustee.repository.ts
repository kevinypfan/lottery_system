import {DefaultCrudRepository, repository, HasManyRepositoryFactory} from '@loopback/repository';
import {Trustee, TrusteeRelations, LotteryItem} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject, Getter} from '@loopback/core';
import {LotteryItemRepository} from './lottery-item.repository';

export class TrusteeRepository extends DefaultCrudRepository<
  Trustee,
  typeof Trustee.prototype.id,
  TrusteeRelations
> {

  public readonly lotteryItems: HasManyRepositoryFactory<LotteryItem, typeof Trustee.prototype.id>;

  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource, @repository.getter('LotteryItemRepository') protected lotteryItemRepositoryGetter: Getter<LotteryItemRepository>,
  ) {
    super(Trustee, dataSource);
    this.lotteryItems = this.createHasManyRepositoryFactoryFor('lotteryItems', lotteryItemRepositoryGetter,);
    this.registerInclusionResolver('lotteryItems', this.lotteryItems.inclusionResolver);
  }
}
