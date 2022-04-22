// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/screen/UserHome/FarmerProducts.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/method.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("user");
  final TextEditingController scearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 3, child: heder()),
          SizedBox(height: 10.h),
//---------------------------------------------
          Input(
            controller: scearch,
            hintText: 'البحث عن منتج',
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter(
                  RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                  allow: true)
            ],
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            icon: Icons.search,
          ),
          SizedBox(height: 20.h),
//---------------------------------------------
          Expanded(flex: 4, child: body()),
        ],
      ),
    );
  }

//---------------------------------------------------------------
  Widget heder() {
    return Container(
      decoration: decorationImage(20, 20, 0, 0,
          color: green!, image: "assets/images/farmer.jpg"),
      height: double.infinity,
      width: double.infinity,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: 200.w,
          height: 40.h,
          decoration: decoration(10, 10, 10, 10, color: green!),
          child: Center(
            child: const AppText(text: "من المزارع مباشرة", color: white),
          ),
        ),
      ),
    );
  }

  Widget body() {
    return Column(
      children: [
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(left:8.0.w,right:8.0.w),
              child: AppText(text: "المزارع المتوفرة  ", color: black),
            )),
        Expanded(
            child: Padding(
          padding:  EdgeInsets.all(8.0.w),
          child: StreamBuilder(
              stream: productCollection
                  .where('userType', isEqualTo: "مزارع")
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
    );
  }

//------------------------------------------------------
  Widget getFarmer(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? GridView.builder(
            itemCount: snapshat.data.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //عدد العناصر في كل صف
                crossAxisSpacing: 20, // المسافات الراسية
                childAspectRatio: 0.70, //حجم العناصر
                mainAxisSpacing: 2 //المسافات الافقية

                ),
            itemBuilder: (context, i) {
              return SizedBox(
                height: 180.h,
                child: InkWell(
                  onTap: () {
                    Push.to(
                        context,
                        FarmerProducts(
                          farmId: snapshat.data.docs[i].data()['userID'],
                        ));
                  },
                  child: Card(
                      elevation: 10,
                      color: white,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 3,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.r),
                                    topRight: Radius.circular(4.r)),
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              )),
//--------------------------------------------------------
                          Expanded(
                              flex: 1,
                              child: Container(
                                width: double.infinity,
                                decoration:
                                    decoration(3, 3, 0, 0, color: green!),
                                child: Center(
                                  child: AppText(
                                      text: "مزرعة "
                                          "${snapshat.data.docs[i].data()['farmName']}",
                                      color: black),
                                ),
                              )),
                        ],
                      )),
                ),
              );
            })
        : const Align(
            alignment: Alignment.center,
            child: AppText(text: "لاتوجد مزارع لعرضها حاليا"));
  }
}
