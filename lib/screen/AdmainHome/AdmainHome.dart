// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/method.dart';
import 'package:farm/widget/showMessage.dart';
import 'package:farm/widget/varaible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'adanceSearch.dart';

class AdmainHome extends StatefulWidget {
  AdmainHome({Key? key}) : super(key: key);

  @override
  State<AdmainHome> createState() => _AdmainHomeState();
}

class _AdmainHomeState extends State<AdmainHome> {
  List userRecord = [];
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("user");

//search user----------------------------------------
  Future getdata() async {
    userCollection.get().then((value) {
      for (var element in value.docs) {
        setState(() {
          userRecord.add(element.data()['phone']);
        });
      }
    });
  }

  //--------------------------------------------------------

  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar("إدارة المستخدمين", context, icone: Icons.search,
            on_Tap: () {
          showSearch(context: context, delegate: Search(list: userRecord));
        }),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          //color: green,
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: userCollection
                  .orderBy('userType', descending: true)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshat) {
                if (snapshat.hasError) {
                  showMessage(context, "ادارة المستخدمين",
                      "خطا في استرجاع البيانات من قاعدة البيانات");
                }
                if (snapshat.hasData) {
                  return getUsers(context, snapshat);
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
        ),
      ),
    );
  }

  //show products-------------------------------
  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
      child: ListView.builder(
          //shrinkWrap: true,
          itemCount: snapshat.data.docs.length,
          itemBuilder: (context, i) {
//delete----------------------------------------------------------
            return movedCellRemov(
              snapshat.data.docs[i].id,
//end delete--------------------------------------------------------
              SizedBox(
                height: 180.h,
                child: Card(
                  elevation: 5,
                  color: white,
                  child: Column(
                    children: [
//userType----------------------------------------------------------------
                      Expanded(
                        flex: 1,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(top: 5.h),
                          decoration: decoration(0, 0, 4, 4, color: green!),
                          child: AppText(
                            text: snapshat.data.docs[i].data()['userType'],
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: white,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
//detiels----------------------------------------------------------------

                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
//Row 1=====================================================================================
                            Expanded(
                              child: Row(children: [
//owner name---------------------------------------------------------
                                getData(
                                    snapshat.data.docs[i].data()['ownerName'],
                                    nameIcon),
                                divider(),
//agriculturalRegistry or commercialRegister---------------------------------------------------------

                                getData(
                                    snapshat.data.docs[i].data()['userType'] ==
                                            "مستخدم"
                                        ? snapshat.data.docs[i]
                                            .data()['commercialRegister']
                                        : snapshat.data.docs[i]
                                            .data()['agriculturalRegistry'],
                                    recordIcon),
                              ]),
                            ),
//Row 2=====================================================================================
                            Expanded(
                              child: Row(children: [
//farmName or facilityName---------------------------------------------------------

                                getData(
                                    snapshat.data.docs[i].data()['userType'] ==
                                            "مستخدم"
                                        ? snapshat.data.docs[i]
                                            .data()['facilityName']
                                        : snapshat.data.docs[i]
                                            .data()['farmName'],
                                    buildName),
                                divider(),
//phone---------------------------------------------------------

                                getData(snapshat.data.docs[i].data()['phone'],
                                    phoneIcon),
                              ]),
                            ),

//Row 3=====================================================================================
                            Expanded(
                              child: Row(children: [
//city name---------------------------------------------------------
                                getData(
                                    snapshat.data.docs[i].data()['city'], city),

                                divider(),
//Emile ---------------------------------------------------------

                                getData(snapshat.data.docs[i].data()['Emile'],
                                    emailIcon),
                              ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

//get data from database--------------------------------------
  Widget getData(text, icon) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Row(children: [
          Icon(
            icon,
            color:green,
          ),
          SizedBox(width: 5.w),
          AppText(
            text: text,
            fontSize: 12.3,
            fontWeight: FontWeight.bold,
            color: black,
            textAlign: TextAlign.center,
          ),
        ]),
      ),
    );
  }

//delete data--------------------------------------------------------
  Widget movedCellRemov(String id, Widget child) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      secondaryBackground: Container(),
      background: Container(
        color: Colors.red,
        child: Padding(
          padding: EdgeInsets.all(15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.0.w, vertical: 5.h),
                child: Icon(Icons.delete, color: Colors.white, size: 36.sp),
              ),
              const AppText(
                color: white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                text: "خذف المستخدم",
              ),
            ],
          ),
        ),
      ),
      confirmDismiss: (DismissDirection direction) async {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const AppText(
                color: black,
                fontSize: 16,
                textAlign: TextAlign.center,
                // fontWeight: FontWeight.bold,
                text: "تأكيد الحذف",
              ),
              content: const AppText(
                  color: black,
                  fontSize: 14,
                  textAlign: TextAlign.center,
                  text: "هل أنت متأكد أنك تريد حذف هذالمستخدم؟"),
              actions: [
                FlatButton(
                  onPressed: () {
                    setState(() {
                      FirebaseFirestore.instance
                          .collection('user')
                          .doc(id)
                          .delete()
                          .then((value) {});
                      setState(() {});
                    });

                    Navigator.of(context).pop(true);
                  },
                  child: AppText(
                      color: green!,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      text: "حذف"),
                ),
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const AppText(
                      color: black,
                      fontSize: 12,
                      //fontWeight: FontWeight.bold,
                      text: "الغاء"),
                ),
              ],
            );
          },
        );
      },
      key: UniqueKey(),
      child: child,
    );
  }
}
