const String getDeviceQuery = r'''
 query GetDevice($id: String!) {
  getDevice(id: $id) {
    id
    isVerify
    name
    model
    version
    storeId
  }
}
''';

const String newDeviceMutaion = r'''
mutation ($input: DeviceInput) {
  newDevice(input: $input) {
    id
    isVerify
    name
    model
    version
    storeId
  }
}
''';
