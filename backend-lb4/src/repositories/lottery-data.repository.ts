import {DefaultCrudRepository} from '@loopback/repository';
import {LotteryData, LotteryDataRelations} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class LotteryDataRepository extends DefaultCrudRepository<
  LotteryData,
  typeof LotteryData.prototype.id,
  LotteryDataRelations
> {
  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
  ) {
    super(LotteryData, dataSource);
  }
}
