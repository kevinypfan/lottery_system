import 'package:flutter/material.dart';

import '../widgets/barcode_scanner.dart';

import '../screens/lottery_data_screen.dart';
import '../screens/trustee_profile_screen.dart';
import '../models/bottom_navigation_item.dart';

class DefaultLayout extends StatefulWidget {
  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {
  int _selectedIndex = 0;
  List<BottomNavigationItem> _bottomNavigations = [
    BottomNavigationItem(
      title: '首頁',
      icon: Icons.home,
      child: LotteryDataScreen(),
    ),
    BottomNavigationItem(
      title: '庫存',
      icon: Icons.inbox,
      child: Center(
        child: Text("庫存頁面尚未開發完成"),
      ),
    ),
    BottomNavigationItem(
      title: '經銷人',
      icon: Icons.account_box,
      child: Center(
        child: TrusteeProfileScreen(),
      ),
    )
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (!device.isAllow) {
    //   Navigator.of(context).pushNamed(
    //     ErrorScreen.routeName,
    //     arguments: ErrorArguments(code: 'Forbidden', message: '請先向管理員要求存取權限！'),
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text('Lottery'),
        actions: <Widget>[
          BarcodeScan('default'),
        ],
      ),
      body: _bottomNavigations[_selectedIndex].child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: _bottomNavigations
            .map(
              (navItem) => BottomNavigationBarItem(
                icon: Icon(navItem.icon),
                title: Text(navItem.title),
              ),
            )
            .toList(),
      ),
    );
  }
}
