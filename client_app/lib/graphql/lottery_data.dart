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

const getLotteryItemByIdQuery = r'''
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
