import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

import '../plugin/graphql.dart';
import '../models/trustee.dart';
import '../graphql/trustee.dart';
import '../models/barcode_argument.dart';
import '../widgets/loading_view.dart';

class RateOption {
  final String label;
  double rate;
  RateOption({this.label, this.rate});
}

class IntoStockScreen extends StatefulWidget {
  static const routeName = 'into-stock-screen';

  @override
  _IntoStockScreenState createState() => _IntoStockScreenState();
}

class _IntoStockScreenState extends State<IntoStockScreen> {
  Trustee _seletedTrustee;
  RateOption _seletedRate;
  List<Trustee> _trustees;
  FocusNode _rateNode = FocusNode();
  TextEditingController _rateController = TextEditingController();
  double _rate = 90;
  List<RateOption> _rates = [
    RateOption(
      label: "一般(92%)",
      rate: 92,
    ),
    RateOption(
      label: "其他比率",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _rateController.text = _rate.toString();
    fetchTrustees();
  }

  void fetchTrustees() async {
    final QueryOptions getTrusteesOption = QueryOptions(
      document: getTrusteesQuery,
    );

    final QueryResult getTrustees =
        await graphQLClient.query(getTrusteesOption);

    if (getTrustees.hasErrors) {
      print(getTrustees.errors);
    }

    List<Trustee> tempList = [];

    getTrustees.data['trustees'].forEach((item) {
      tempList.add(Trustee.fromJson(item));
    });

    setState(() {
      _trustees = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BarcodeArgument args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text("加入庫存"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: _trustees == null
          ? LoadingView()
          : Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        '序號: ${args.serial}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '領取者: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      DropdownButton<Trustee>(
                        hint: new Text("請選擇"),
                        value: _seletedTrustee,
                        onChanged: (Trustee newValue) {
                          setState(() {
                            _seletedTrustee = newValue;
                          });
                        },
                        items: _trustees.map((Trustee trustee) {
                          return DropdownMenuItem<Trustee>(
                            value: trustee,
                            child: Text(
                              trustee.name,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '進貨比率: ',
                        style: TextStyle(fontSize: 18),
                      ),
                      DropdownButton<RateOption>(
                        hint: new Text("請選擇"),
                        value: _seletedRate,
                        onChanged: (RateOption newValue) {
                          if (newValue.rate == null &&
                              newValue.label == "其他比率") {
                            FocusScope.of(context).requestFocus(_rateNode);
                          }
                          setState(() {
                            _seletedRate = newValue;
                          });
                        },
                        items: _rates.map((RateOption rate) {
                          return DropdownMenuItem<RateOption>(
                            value: rate,
                            child: Text(
                              rate.label,
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  _seletedRate != null &&
                          (_seletedRate.rate == null &&
                              _seletedRate.label == "其他比率")
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 200,
                                child: TextField(
                                  focusNode: _rateNode,
                                  decoration:
                                      InputDecoration(labelText: "輸入進貨比率"),
                                  controller: _rateController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (String newValue) {
                                    _rate = num.tryParse(newValue);
                                  },
                                ),
                              ),
                            ),

                            // TextFormField(
                            //   keyboardType: TextInputType.number,
                            //   decoration: InputDecoration(
                            //       prefixIcon: Text("Enter the rate number: ")),
                            //   initialValue: _rate.toString(),
                            //   focusNode: _rateNode,
                            //   onSaved: (input) => _rate = num.tryParse(input),
                            // ),
                          ],
                        )
                      : Container(),
                ],
              ),
            ),
    );
  }
}
