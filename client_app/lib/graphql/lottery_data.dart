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
