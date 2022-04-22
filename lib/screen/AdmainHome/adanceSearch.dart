import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/method.dart';
import 'package:farm/widget/showMessage.dart';
import 'package:farm/widget/varaible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends SearchDelegate<String> {
  final List<dynamic> list;

  Search({required this.list});

  @override
  List<Widget> buildActions(BuildContext context) {
    // Action of app bar
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // الايقون الموجودة قبل المربع النصي
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

//buildResults------------------------------------------------------
  @override
  Widget buildResults(BuildContext context) {
    CollectionReference<Map<String, dynamic>> userCollection =
    FirebaseFirestore.instance.collection("user");

    // نتيجة البحث
    return Directionality(
      textDirection: TextDirection.rtl,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: userCollection.where('phone', isEqualTo: query).get(),
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
    );
  } //bulid result


//buildSuggestions-----------------------------------------------------------------------------------
  @override
  Widget buildSuggestions(BuildContext context) {
    var listSearch = query.isEmpty
        ? list
        : list
        .where(
            (phone) => phone.startsWith(query))
        .toList();
    return ListView.builder(
        itemCount: listSearch.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              query = listSearch[index];
              showResults(context);
            },
            leading: const Icon(Icons.phone),
            title: Text(listSearch[index]),
          );
        });
  }

//-----------------------------------------------------------------------------
  //show products-------------------------------
  Widget getUsers(BuildContext context, AsyncSnapshot snapshat) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 10.h),
      child: ListView.builder(
        //shrinkWrap: true,
          itemCount: snapshat.data.docs.length,
          itemBuilder: (context, i) {
            return SizedBox(
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
                              getData(snapshat.data.docs[i].data()['ownerName'],
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
            );
          }),
    );
  }

  Widget getData(text, icon) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Row(children: [
          Icon(
            icon,
            color: green,
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
}
