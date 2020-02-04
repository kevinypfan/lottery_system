import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';

import '../plugin/graphql.dart';
import '../graphql/trustee.dart';

class TrusteeItem {
  int id;
  String name;
  String cardCode;
  String bank;
  String store;
  String identity;
  DateTime birthday;
  String hex;
  String phone;
  String consignee_1;
  String consignee_2;

  TrusteeItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        cardCode = json['card_code'],
        bank = json['bank'],
        store = json['store'],
        identity = json['identity'],
        hex = json['hex'],
        phone = json['phone'],
        consignee_1 = json['consignee_1'],
        consignee_2 = json['consignee_2'],
        birthday =
            json['birthday'] == null ? null : DateTime.parse(json['birthday']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'cardCode': cardCode,
        'bank': bank,
        'store': store,
        'identity': identity,
        'birthday': birthday,
        'hex': hex,
        'phone': phone,
        'consignee_1': consignee_1,
        'consignee_2': consignee_2,
      };
}

class TrusteeData with ChangeNotifier {
  List<TrusteeItem> _items = [];

  List<TrusteeItem> get items => _items;

  TrusteeItem findOneById(int id) {
    // print(id);
    // print(_items.firstWhere((trustee) => trustee.id == id).toJson());
    // print(_items[0].toJson());
    return _items.firstWhere((trustee) => trustee.id == id);
  }

  Future<List<TrusteeItem>> fetchTrusteeData() async {
    _items = [];
    final QueryOptions getTrusteeDataOption = QueryOptions(
      document: getTrusteesQuery,
    );

    final QueryResult getTrusteeData =
        await graphQLClient.query(getTrusteeDataOption);
    if (getTrusteeData.hasErrors) {
      print(getTrusteeData.errors);
    }
    getTrusteeData.data['trustees'].forEach((item) {
      _items.add(TrusteeItem.fromJson(item));
    });
    notifyListeners();
    return _items;
  }
}
