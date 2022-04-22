import 'package:farm/screen/FarmerHome/Manage%20Product/product.dart';
import 'package:farm/screen/FarmerHome/Manage%20Request/requist.dart';
import 'package:farm/screen/FarmerHome/profile.dart';
import 'package:flutter/material.dart';

class navHome extends StatefulWidget {
  navHome({Key? key}) : super(key: key);

  @override
  State<navHome> createState() => _navHomeState();
}

class _navHomeState extends State<navHome> {
  @override
  int _selectedIndex = 1;
  final List page = [

    Request(),
    Products(),
    Profile(),


  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: page[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          elevation: 4,
          unselectedFontSize: 10,
          currentIndex: _selectedIndex,
          onTap: onTabTapped,
          items: const [


            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "الطلبات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: "المنتجات",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "الملف الشخصي",
            ),


          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

//"${snapshat.data.docs[i].data()['ordersName'][j]}"