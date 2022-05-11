import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/Colors.dart';
import '../../widget/app_text.dart';
import '../../widget/btn.dart';
import '../../widget/method.dart';
import '../../widget/showMessage.dart';
import '../../widget/varaible.dart';

class UserCar extends StatefulWidget {
  UserCar({Key? key}) : super(key: key);

  @override
  State<UserCar> createState() => _UserCarState();
}

class _UserCarState extends State<UserCar> {
  String? currentUser;
  String? userPhone;
  String? name;
  var userItem = [];

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
    listRefrash();
//-------------------------------------------------------

//----------------------------------------------
    userCollection
        .where('userID', isEqualTo: currentUser)
        .where("userType", isEqualTo: "مستخدم")
        .get()
        .then((value) {
      for (var element in value.docs) {
        setState(() {
          name = element["facilityName"];
          userPhone = element["phone"];
        });
      }
    });
  }

  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("card");
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("user");
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
                      .where("state", isEqualTo: 0)
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
                      padding: EdgeInsets.only(
                          right: 17.0.w, left: 17.0.w, bottom: 8.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                              text: "الاجمالي $totalPrice ريال ", color: black),
                          AppText(
                              text: "عدد الطلبات ${snapshat.data.docs.length}",
                              color: black),
                        ],
                      ))),
              Expanded(
                child: ListView.builder(
                    itemCount: snapshat.data.docs.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          tileColor: gry,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppText(
                                text:
                                    '${snapshat.data.docs[i].data()['prName']}',
                              ),
                              AppText(
                                text:
                                    'مزرعة ${snapshat.data.docs[i].data()['farmName']}',
                              ),
                            ],
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
                                  FirebaseFirestore.instance
                                      .collection('card')
                                      .doc("${snapshat.data.docs[i].id}")
                                      .delete();
                                  listRefrash();
                                });
                              },
                              icon: const Icon(Icons.remove_circle,
                                  color: Colors.red)),
                        ),
                      );
                    }),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Btn(
                  color: green,
                  onPressed: () {
                    print(userItem);
                    showMessage(context, "", "lode");
                    FirebaseFirestore.instance.collection("order").add({
                      "orderId": orderNumber(),
                      "data": userItem,
                      "userName": name,
                      "phone": userPhone,
                    }).then((value) {
                      showMessage(context, "ارسال الطلب",
                          "شكرا لطلبك من  مزرعتنا, لقد تم ارسال طلبك وسيتواصل معك مندوب المزرعة لاكمال عملية الدفع");
                      //show item in order table
                      cardCollection
                          .where("userId", isEqualTo: currentUser)
                          .get()
                          .then((snapshot) {
                        for (DocumentSnapshot ds in snapshot.docs) {
                          ds.reference.update({
                            "state": 1,
                          });
                        }
                      });
                    });
                  },
                  title: 'تاكيد الطلبات',
                  txtColor: white,
                ),
              ),
            ],
          )
        : const Align(
            alignment: Alignment.center,
            child: AppText(text: "السلة فارغة حاليا"));
  }

  listRefrash() {
    userItem.clear();
    cardCollection
        .where('userId', isEqualTo: currentUser)
        .where("state", isEqualTo: 0)
        .get()
        .then((value) {
      for (var element in value.docs) {
        userItem.add(element.data());
      }
    });
  }
}
