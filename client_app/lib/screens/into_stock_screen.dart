// import 'package:flutter/material.dart';
// import 'package:graphql/client.dart';
// import 'package:provider/provider.dart';

// import '../providers/device.dart';
// import '../plugin/graphql.dart';
// import '../providers/trustee.dart';
// import '../graphql/trustee.dart';
// import '../models/barcode_argument.dart';
// import '../widgets/loading_view.dart';
// import '../graphql/lottery_data.dart';

// class RateOption {
//   final String label;
//   num rate;
//   RateOption({this.label, this.rate});
// }

// class IntoStockScreen extends StatefulWidget {
//   static const routeName = 'into-stock-screen';

//   @override
//   _IntoStockScreenState createState() => _IntoStockScreenState();
// }

// class _IntoStockScreenState extends State<IntoStockScreen> {
//   Trustee _seletedTrustee;
//   RateOption _seletedRate;
//   List<Trustee> _trustees;
//   FocusNode _rateNode = FocusNode();
//   TextEditingController _rateController = TextEditingController();
//   List<RateOption> _rates = [
//     RateOption(
//       label: "一般(92%)",
//       rate: 92,
//     ),
//     RateOption(
//       label: "其他比率",
//     ),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _rateController.text = 90.toString();
//     fetchTrustees();
//   }

//   void fetchTrustees() async {
//     final QueryOptions getTrusteesOption = QueryOptions(
//       document: getTrusteesQuery,
//     );

//     final QueryResult getTrustees =
//         await graphQLClient.query(getTrusteesOption);

//     if (getTrustees.hasErrors) {
//       print(getTrustees.errors);
//     }

//     List<Trustee> tempList = [];

//     getTrustees.data['trustees'].forEach((item) {
//       tempList.add(Trustee.fromJson(item));
//     });

//     setState(() {
//       _trustees = tempList;
//     });
//   }

//   Future<bool> submitSaveHandler(BarcodeArgument args, Device device) async {
//     Map<String, dynamic> sendBody = {
//       'number': args.numberCode,
//       'importRate': _seletedRate.rate == null
//           ? num.tryParse(_rateController.text)
//           : _seletedRate.rate,
//       'trusteeId': _seletedTrustee.id,
//       'lotteryDataId': args.firstCode,
//       'storeId': device.storeId,
//       'serial': args.serial,
//       'deviceId': device.identifier
//     };
//     print(sendBody);

//     final MutationOptions newLotteryItemOption = MutationOptions(
//       document: newLotteryItemMutation,
//       variables: <String, dynamic>{
//         'input': sendBody,
//       },
//     );
//     final QueryResult result = await graphQLClient.mutate(newLotteryItemOption);

//     if (result.hasErrors) {
//       print(result.errors);
//       return false;
//     }
//     return true;
//   }

//   Future<void> _neverSatisfied({
//     String title,
//     String content,
//     String btnText,
//   }) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(content),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text(btnText),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final BarcodeArgument args = ModalRoute.of(context).settings.arguments;
//     final Device device = Provider.of<Device>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("加入庫存"),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.save),
//             onPressed: () {
//               submitSaveHandler(args, device).then((result) {
//                 print(result);
//                 if (result) {
//                   _neverSatisfied(
//                     title: '新增成功',
//                     content: '已經增成功至庫存！',
//                     btnText: "Okay",
//                   ).then((_) {
//                     print('done');
//                     Navigator.of(context).pop();
//                     Navigator.of(context).pop();
//                   });
//                 } else {
//                   _neverSatisfied(
//                     title: '新增失敗',
//                     content: '發生錯誤，請通知開發人員！',
//                     btnText: "Back",
//                   ).then((_) {
//                     print('done');
//                   });
//                 }
//               });
//             },
//           )
//         ],
//       ),
//       body: _trustees == null
//           ? LoadingView()
//           : Container(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     children: <Widget>[
//                       Text(
//                         '序號: ${args.serial}',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Flexible(
//                         flex: 3,
//                         child: Text(
//                           '領取者: ',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Flexible(
//                         flex: 8,
//                         fit: FlexFit.tight,
//                         child: DropdownButton<Trustee>(
//                           hint: new Text("請選擇"),
//                           isExpanded: true,
//                           value: _seletedTrustee,
//                           onChanged: (Trustee newValue) {
//                             setState(() {
//                               _seletedTrustee = newValue;
//                             });
//                           },
//                           items: _trustees.map((Trustee trustee) {
//                             return DropdownMenuItem<Trustee>(
//                               value: trustee,
//                               child: Text(
//                                 trustee.name,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Row(
//                     children: <Widget>[
//                       Flexible(
//                         flex: 3,
//                         child: Text(
//                           '進貨比率: ',
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       Flexible(
//                         flex: 7,
//                         child: DropdownButton<RateOption>(
//                           hint: new Text("請選擇"),
//                           value: _seletedRate,
//                           isExpanded: true,
//                           onChanged: (RateOption newValue) {
//                             if (newValue.rate == null &&
//                                 newValue.label == "其他比率") {
//                               FocusScope.of(context).requestFocus(_rateNode);
//                             }
//                             setState(() {
//                               _seletedRate = newValue;
//                             });
//                           },
//                           items: _rates.map((RateOption rate) {
//                             return DropdownMenuItem<RateOption>(
//                               value: rate,
//                               child: Text(
//                                 rate.label,
//                                 style: TextStyle(color: Colors.black),
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ],
//                   ),
//                   _seletedRate != null && _seletedRate.label == "其他比率"
//                       ? Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: SizedBox(
//                                 height: 200,
//                                 child: TextField(
//                                   focusNode: _rateNode,
//                                   decoration:
//                                       InputDecoration(labelText: "輸入進貨比率"),
//                                   controller: _rateController,
//                                   keyboardType: TextInputType.number,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         )
//                       : Container(),
//                 ],
//               ),
//             ),
//     );
//   }
// }
