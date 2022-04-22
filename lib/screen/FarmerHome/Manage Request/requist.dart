import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Request extends StatefulWidget {
  Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  CollectionReference<Map<String, dynamic>> orderCollection =
  FirebaseFirestore.instance.collection("order");
  List orderName = [];
  List orderquantity = [];

  //get all reqest data from datbase

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBarHome("ادارة الطلبات", context),
          body: Container(
            // color: Colors.red,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FutureBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                            future: orderCollection.get(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshat) {
                              if (snapshat.hasError) {
                                print("ERRRRRRRRRRRRRRRRRRRRRRRRRRRRRO");
                              }
                              if (snapshat.hasData) {
                                print(snapshat.data.runtimeType);
                                return product(context, snapshat);
                              }
                              // }  if (snapshat.hasData==null) {
                              //   print("NO DAAAAAAAAAAAAAAAAAAAATA FOUND");
                              // }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      )),
                ],
              ))),
    );
  }

//show products-------------------------------
  Widget product(BuildContext context, AsyncSnapshot snapshat) {
    return ListView.builder(
      //shrinkWrap: true,
        itemCount: snapshat.data.docs.length,
        itemBuilder: (context, i) {
          return SizedBox(
            height: 160.h,
            child: Card(
              elevation: 10,
              color: deepwhite,
              child: Row(
                children: [
//product accebtReject-------------------------------------
                  Expanded(
                    flex: 2,
                    child: Container(
                        decoration: decoration(0, 7, 0, 7, color: green!),
                        child: accsebtRetjectBtn()),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
// اسم الجهه----------------------------------------------
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(top: 13.0.h),
                              child: AppText(
                                text: snapshat.data.docs[i].data()['userName'],
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
//product heder----------------------------------------------
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(child: heder("اسم المنتج")),
                                    divider(),
                                    Expanded(child: heder("السعر")),
                                    divider(),
                                    Expanded(child: heder(" الكمية")),

                                  ],
                                ),
                              ),

                            )),
//----------------------------------------------------------------------------
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding:
                              EdgeInsets.only(left: 8.0.w, right: 8.0.w),
                              child: Column(
                                //  crossAxisAlignment: CrossAxisAlignment.center,
                                //  mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  getOrder(
                                    snapshat,
                                    i,
                                  ),
                                ],
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

//---------------------------------------------------------------------------------------------------------
  accsebtRetjectBtn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
// الاجمالي-----------------------------------------------

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText(
              text: "الاجمالي :  ",
              fontSize: 13.sp,
              color: white,
              fontWeight: FontWeight.bold,
            ),
            AppText(
              text: "9000 ر.س",
              fontSize: 13.sp,
              color: white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
        SizedBox(height: 5.h),
//قبول الطلب-----------------------------------------------
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Btn(
            color: white,
            txtColor: Colors.green,
            onPressed: () {},
            title: 'قبول',
          ),
        ),

//رفض الطلب-----------------------------------------------

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Btn(
            color: white,
            txtColor: Colors.green,
            onPressed: () {},
            title: 'رفض',
          ),
        ),
      ],
    );
  }

//----------------------------------------------------------------------------
  Widget getOrder(snapshat, i) {
    return Expanded(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: snapshat.data.docs[i].data()['ordersName'].length,
          itemBuilder: (context, j) {
            return Row(

              children: [
                Expanded(
                  child: AppText(
                    fontSize: 12,
                    text: "${snapshat.data.docs[i].data()['ordersName'][j]}",
                  ),
                ),
                divider(),
                Expanded(
                  child: AppText(
                    fontSize: 12,
                    text: "${snapshat.data.docs[i].data()['quantity'][j]}",
                  ),
                ),
                divider(),
                Expanded(
                  child: AppText(
                    fontSize: 12,
                    text: "${snapshat.data.docs[i].data()['quantity'][j]}",
                  ),
                )
              ],
            );
          }),
    );
  }

  Widget heder(String name) {
    return AppText(
      text: name,
      fontSize: 14.sp,
      fontWeight: FontWeight.bold,
      color: green!,
    );
  }
}
