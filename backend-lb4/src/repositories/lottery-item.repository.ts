import {DefaultCrudRepository} from '@loopback/repository';
import {LotteryItem, LotteryItemRelations} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class LotteryItemRepository extends DefaultCrudRepository<
  LotteryItem,
  typeof LotteryItem.prototype.id,
  LotteryItemRelations
> {
  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
  ) {
    super(LotteryItem, dataSource);
  }
}
