import {DefaultCrudRepository} from '@loopback/repository';
import {Trustee, TrusteeRelations} from '../models';
import {PostgresDataSource} from '../datasources';
import {inject} from '@loopback/core';

export class TrusteeRepository extends DefaultCrudRepository<
  Trustee,
  typeof Trustee.prototype.id,
  TrusteeRelations
> {
  constructor(
    @inject('datasources.postgres') dataSource: PostgresDataSource,
  ) {
    super(Trustee, dataSource);
  }
}
