import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/Colors.dart';
import '../../widget/app_text.dart';
import '../../widget/method.dart';
import '../../widget/varaible.dart';

class UserCar extends StatefulWidget {
  UserCar({Key? key}) : super(key: key);

  @override
  State<UserCar> createState() => _UserCarState();
}

class _UserCarState extends State<UserCar> {
  String? currentUser;
  var totalPrice = 0.0;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;

    cardCollection.where('userId', isEqualTo: currentUser).get().then((value) {
      for (var element in value.docs) {
        setState(() {
          totalPrice += element["total price"];
        });
      }
    });
  }

  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("card");
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarHome("سلة التسوق", context),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: StreamBuilder(
                  stream: cardCollection
                      .where('userId', isEqualTo: currentUser)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot snapshat) {
                    if (snapshat.hasError) {
                      return Text("${snapshat.error}");
                    }
                    if (snapshat.hasData) {
                      return getFarmer(context, snapshat);
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            )),
          ],
        ),
      ),
    );
  }

  Widget getFarmer(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? Column(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: 17.0.w, bottom: 8.0.h),
                    child: AppText(
                        text: "الاجمالي $totalPrice ريال ", color: black),
                  )),
              Expanded(
                child: ListView.builder(
                    itemCount: snapshat.data.docs.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: gry,
                          title: AppText(
                            text: '${snapshat.data.docs[i].data()['prName']}',
                          ),
                          subtitle: Row(
                            children: [
                              Icon(quantity, color: green, size: 20.sp),
                              AppText(
                                text:
                                    ' ${snapshat.data.docs[i].data()['quantity']}      ',
                              ),
                              Icon(mony, color: green, size: 20.sp),
                              AppText(
                                text:
                                    ' ${snapshat.data.docs[i].data()['total price']}',
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('card')
                                    .doc("${snapshat.data.docs[i].id}")
                                    .delete();
                                setState(() {
                                  totalPrice -= snapshat.data.docs[i]
                                      .data()['total price'];
                                });
                              },
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red)),
                        ),
                      );
                    }),
              )
            ],
          )
        : const Align(
            alignment: Alignment.center,
            child: AppText(text: "السلة فارغة حاليا"));
  }
}
