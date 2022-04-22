// ignore_for_file: avoid_unnecessary_containers, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/screen/UserHome/UserCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tools/push.dart';
import '../../widget/Colors.dart';
import '../../widget/app_text.dart';
import '../../widget/method.dart';
import '../../widget/varaible.dart';
import 'ProductDetials.dart';

class FarmerProducts extends StatefulWidget {
  final farmId;
   FarmerProducts({this.farmId});

  @override
  State<FarmerProducts> createState() => _FarmerProductsState();
}

class _FarmerProductsState extends State<FarmerProducts> {
  CollectionReference productCollection =
      FirebaseFirestore.instance.collection("product");
  String seleced="فواكهة";
  bool fruitBottom = true;
  bool papersBottom = false;
  bool vegetablesBottom = false;
  bool datesBottom = false;
  List<String> title = [
    "فواكهة",
    "خضروات",
    "ورقيات",
    "تمور"
  ];
  List<double> widgetWidth = [70, 70, 70, 70, 50];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBar("المنتجات", context, icone: card,on_Tap: ()=>Push.to(context, UserCar())),
          body: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 100.h,
                child: Center(
                  child: Wrap(runSpacing: 13.0.h, spacing: 12.0.w, children: [
                    //all(),
                    fruit(),
                    vegetables(),
                    papers(),
                    dates(),
                  ]),
                ),
//-----------------------------------------------------------
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder(
                    stream: productCollection
                        .where('userID', isEqualTo: widget.farmId)
                        .where("prCatogary",isEqualTo:seleced).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshat) {
                      if (snapshat.hasError) {
                        return Text("${snapshat.error}");
                      }
                      if (snapshat.hasData) {
                        return getProducts(context, snapshat);
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }),
              )),
            ],
          )),
    );
  }

//------------------------------------------------------------------------
  Widget getProducts(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? GridView.builder(
            itemCount: snapshat.data.docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                   Push.toReplace(context, ProductDeials(
                      image:snapshat.data.docs[i].data()['imagePath'], 
                      price :snapshat.data.docs[i].data()['prPrice'],
                      quantity :snapshat.data.docs[i].data()['prQuantity'], 
                      decsription:snapshat.data.docs[i].data()['prdescription'],
                      pr_id:snapshat.data.docs[i].data()['productID'],
                       pr_name:snapshat.data.docs[i].data()['prName']

                    ));
                  },
                  child: Card(
                      elevation: 10,
                      color: white,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 4,
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.r),
                                    topRight: Radius.circular(4.r)),
                                child: Image.network(
                                 "${snapshat.data.docs[i].data()['imagePath']}",
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                ),
                              )),
//--------------------------------------------------------
                          Expanded(
                              flex: 2,
                              child: Container(
                                width: double.infinity,
                                decoration:
                                    decoration(3, 3, 0, 0, color: green!),
                                child: Column(
                                  children: [
                                    Center(
                                      child: AppText(
                                          text: 
                                              "${snapshat.data.docs[i].data()['prName']}",
                                          color: white),
                                    
                                    ),
                                    AppText(
                                      text: 
                                          "${snapshat.data.docs[i].data()['prPrice']} ريال",
                                      color: white),
                                  ],
                                ),
                              )),
//------------------------------------------------------

                        ],
                      )),
                ),
              );
            })
        : const Align(
            alignment: Alignment.center,
            child: AppText(text: "لاتوجد منتجات لعرضها حاليا"));
  }

  fruit() {
    return InkWell(
      onTap: () {
        setState(() {
          // allBottom = false;
          fruitBottom = true;
          papersBottom = false;
          vegetablesBottom = false;
          datesBottom = false;
          seleced="فواكهة";
        });
      },
      child: Container(
        decoration: decorationn(
          color: fruitBottom ? green! : Colors.transparent,
        ),
        width: widgetWidth[0],
        height: 40.h,
        child: Center(
            child: AppText(text: title[0], color: fruitBottom ? white : black)),
      ),
    );
  }

//vegetables-----------------------------------------------------
  Widget vegetables() {
    return InkWell(
      onTap: () {
        setState(() {
          // allBottom = false;
          fruitBottom = false;
          papersBottom = false;
          vegetablesBottom = true;
          datesBottom = false;
          seleced="خضروات";
          
        });
      },
      child: Container(
        decoration: decorationn(
          color: vegetablesBottom ? green! : Colors.transparent,
        ),
        width: widgetWidth[1],
        height: 40.h,
        child: Center(
            child: AppText(
                text: title[1], color: vegetablesBottom ? white : black)),
      ),
    );
  }

//papers-----------------------------------------------------
  Widget papers() {
    return InkWell(
      onTap: () {
        setState(() {
          //  allBottom = false;
          fruitBottom = false;
          papersBottom = true;
          vegetablesBottom = false;
          datesBottom = false;
          seleced="ورقيات";
        });
      },
      child: Container(
        decoration: decorationn(
          color: papersBottom ? green! : Colors.transparent,
        ),
        width: widgetWidth[2],
        height: 40.h,
        child: Center(
            child:
                AppText(text: title[2], color: papersBottom ? white : black)),
      ),
    );
  }

//dates-----------------------------------------------------
  Widget dates() {
    return InkWell(
      onTap: () {
        setState(() {
          // allBottom = false;
          fruitBottom = false;
          papersBottom = false;
          vegetablesBottom = false;
          datesBottom = true;
          seleced="تمور";
        });
      },
      child: Container(
        decoration: decorationn(
          color: datesBottom ? green! : Colors.transparent,
        ),
        width: widgetWidth[3],
        height: 40.h,
        child: Center(
            child: AppText(text: title[3], color: datesBottom ? white : black)),
      ),
    );
  }

  //---------------------------------------------------
  decorationn({required Color color}) {
    return BoxDecoration(
      color: color,
      border: Border.all(color: green!, width: 1.5.r),
      borderRadius: BorderRadius.circular(7.r),
    );
  }
}
