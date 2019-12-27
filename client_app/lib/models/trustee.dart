class Trustee {
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

  Trustee.fromJson(Map<String, dynamic> json)
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
