const String getTrusteesQuery = r'''
{
  trustees {
    id
    name
    card_code
    bank
    store
    identity
    birthday
    hex
    phone
    consignee_1
    consignee_2
  }
}
''';
