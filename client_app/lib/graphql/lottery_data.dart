const String getLotteryDatasQuery = r'''
query LotteryDatas($limit: Int, $order: String, $skip: Int, $offset: Int) {
  lotteryDatas(limit: $limit, order: $order, skip: $skip, offset: $offset) {
    id
    name
    price
    image_url
    start_sell
    last_redeem
    stop_sell
  }
}
''';

const String getLotteryItemByIdQuery = r'''
query ($id: String!){
  lotteryData(id: $id) {
    id
    name
    image_url
    price
    max_bonus
    start_sell
    stop_sell
    last_redeem
    max_issue
    max_top
    sales_rate
    unredeemed
  }
}
''';

const String newLotteryItemMutation = r'''
mutation($input: NewLotteryItemInput) {
  newLotteryItem(input: $input) {
    id
    number
    revoked
    createdAt
    exportedAt
    trusteeId
    lotteryDataId
    storeId
    serial
    importRate
    exportRate
    deviceId
    exporter
  }
}
''';
