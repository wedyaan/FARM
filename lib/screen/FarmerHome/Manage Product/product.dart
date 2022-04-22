import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/screen/FarmerHome/Manage%20Product/Add%20new.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'UpdateProducts.dart';

class Products extends StatefulWidget {
  Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  CollectionReference productCollection =
  FirebaseFirestore.instance.collection("product");

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: appBarHome("ادارة المنتجات", context),
          body: Container(
            // color: Colors.red,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12.0.h, bottom: 12.h),
                    child: newProductBtn(),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: StreamBuilder(
                            stream: productCollection.snapshots(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshat) {
                              if (snapshat.hasError) {
                                return Text("${snapshat.error}");
                              }
                              if (snapshat.hasData) {
                                return product(context, snapshat);
                              }

                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }),
                      )),
                ],
              ))),
    );
  }

//add new-------------------------------
  Widget newProductBtn() {
    return Btn(
      color: green,
      txtColor: white,
      width: 120.w,
      onPressed: () {
        Push.to(context, AddNewProduct());
      },
      title: 'اضافة جديد',
    );
  }

//show products-------------------------------
  Widget product(BuildContext context, AsyncSnapshot snapshat) {
    return snapshat.data.docs.length > 0
        ? ListView.builder(
      //shrinkWrap: true,
        itemCount: snapshat.data.docs.length,
        itemBuilder: (context, i) {
          return movedCellRemov(
            snapshat.data.docs[i].id,
            snapshat.data.docs[i].data()['imagePath'],
            SizedBox(
              height: 160,
              child: InkWell(
                onTap: () {
                  Push.to(
                      context,
                      UpdateProduts(
                        addId: snapshat.data.docs[i].id,
                        addimagePath:
                        snapshat.data.docs[i].data()['imagePath'],
                        addprName: snapshat.data.docs[i].data()['prName'],
                        addprPrice: snapshat.data.docs[i].data()['prPrice'],
                        addprQuantity:
                        snapshat.data.docs[i].data()['prQuantity'],
                        addprCatogary:
                        snapshat.data.docs[i].data()['prCatogary'],
                        addprdescription:
                        snapshat.data.docs[i].data()['prdescription'],
                      ));
                },
                child: Card(
                  elevation: 10,
                  color: deepwhite,
                  child: Row(
                    children: [
                      //product image-------------------------------------
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: decoration(
                              snapshat.data.docs[i].data()['imagePath']),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            //product name----------------------------------------------
                            Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 18.0.h),
                                  child: AppText(
                                    text: snapshat.data.docs[i]
                                        .data()['prName'],
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            //product details----------------------------------------------

                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    //السعر-------------------------------------------------
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: "السعر",
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: snapshat.data.docs[i]
                                                    .data()['prPrice'] +
                                                    " رس",
                                                fontSize: 14.sp,
                                                color: green!,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )),
                                    divider(),
                                    //الكمية-------------------------------------------------

                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: "الكمية",
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: snapshat.data.docs[i]
                                                    .data()['prQuantity'],
                                                fontSize: 14.sp,
                                                color: green!,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )),
                                    divider(),
                                    //الفئة-------------------------------------------------

                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: "الفئة",
                                                fontSize: 14.sp,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: AppText(
                                                text: snapshat.data.docs[i]
                                                    .data()['prCatogary'],
                                                fontSize: 14.sp,
                                                color: green!,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        )),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })
        : const Align(
        alignment: Alignment.center,
        child: AppText(text: "لاتوجد منتجات لعرضها حاليا"));
  }

  decoration(String? image) {
    return BoxDecoration(
      color: green,
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(7.r), topRight: Radius.circular(7.r)),
      image:
      DecorationImage(image: NetworkImage("$image"), fit: BoxFit.contain),
    );
  }

  //delete data--------------------------------------------------------
  Widget movedCellRemov(String id, String imageURL, Widget child) {
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
                text: "خذف منتج",
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
                  text: "هل أنت متأكد أنك تريد حذف هذا المنتج"),
              actions: [
                FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);

                    await FirebaseStorage.instance
                        .refFromURL(imageURL)
                        .delete();
                    FirebaseFirestore.instance
                        .collection('product')
                        .doc(id)
                        .delete()
                        .then((value) {});
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
