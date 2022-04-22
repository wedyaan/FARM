import 'package:flutter/material.dart';

import '../../widget/method.dart';
class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome("طلباتي", context),
    );
  }
}