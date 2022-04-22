import 'package:farm/screen/FarmerHome/profile.dart';
import 'package:farm/screen/UserHome/MyOrders.dart';
import 'package:farm/screen/UserHome/UserCard.dart';
import 'package:farm/screen/UserHome/UserHomePage.dart';
import 'package:flutter/material.dart';

class UserNavigationBar extends StatefulWidget {
  UserNavigationBar({Key? key}) : super(key: key);

  @override
  State<UserNavigationBar> createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  int _selectedIndex = 0;
  final List page = [const UserHome(), MyOrders(), UserCar(), Profile()];

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
              icon: Icon(Icons.home_rounded),
              label: "الرئيسية",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_outlined),
              label: "طلباتي",
            ),
            BottomNavigationBarItem(

              icon: Icon(Icons.shopping_cart_rounded),
              label: "السلة",
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