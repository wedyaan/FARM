import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widget/Colors.dart';
import '../../widget/app_text.dart';
import '../../widget/method.dart';
import '../../widget/varaible.dart';

class MyOrders extends StatefulWidget {
  MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

/*

FirebaseFirestore.instance
                        .collection("order")
                       
                        .get()
                        .then((value) {
                          var us=[];
                      for (int i=0;i<value.docs.length;i++) {
                        for (int j = 0; j < value.docs[i]["data"].length; j++) {
                          if(value.docs[i].data()["data"][j]["id"]=="3"){
                           setState(() {us.add(value.docs[i].data()["data"]);});
                          }else{
                            j++;
                          }
                         
                        }
                        
                      }
                      print("length is ${us.length}");
                    });
*/
class _MyOrdersState extends State<MyOrders> {
  String? currentUser;
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("card");
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBarHome("طلباتي", context),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
                child: Padding(
              padding: EdgeInsets.all(8.0.w),
              child: StreamBuilder(
                  stream: cardCollection
                      .where('userId', isEqualTo: currentUser)
                      .where("state", isEqualTo: 1)
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
                  )),
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
                        ),
                      );
                    }),
              ),
            ],
          )
        : const Align(
            alignment: Alignment.center,
            child: AppText(text: "السلة فارغة حاليا"));
  }
}
