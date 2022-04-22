import 'package:farm/widget/method.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarHome("الملف الشخصي", context),
        body: Center(child: Text("Profile"))
    );
  }
}


// ignore_for_file: avoid_function_literals_in_foreach_calls


//"${snapshat.data.docs[i].data()['ordersName'].length}"

/*

ListView.builder(
                                itemCount: snapshat.data.docs[i]
                                    .data()['ordersName']
                                    .length,
                                itemBuilder: (context, j) {
                                  return Text(
                                      "${snapshat.data.docs[i].data()['ordersName'][j]}");
                                })
*/