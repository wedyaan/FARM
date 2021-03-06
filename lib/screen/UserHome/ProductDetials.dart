// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/screen/UserHome/FarmerProducts.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/widget/btn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:counter_button/counter_button.dart';
import '../../widget/Colors.dart';
import '../../widget/app_text.dart';
import '../../widget/method.dart';

class ProductDeials extends StatefulWidget {
  final image;
  final price;
  final quantity;
  final decsription;
  final pr_id;
  final pr_name;
  final farmerId;
  final farmName;
  const ProductDeials(
      {Key? key,
      this.image,
      this.price,
      this.quantity,
      this.decsription,
      this.pr_id,
      this.pr_name,
      this.farmerId,
      this.farmName})
      : super(key: key);

  @override
  State<ProductDeials> createState() => _ProductDeialsState();
}

class _ProductDeialsState extends State<ProductDeials> {
  CollectionReference cardCollection =
      FirebaseFirestore.instance.collection("card");
  int? x;
  String? docId;
  String? currentUser;
  int? dbQuantity;
  int? dbtotalPrice;
  @override
  void initState() {
    super.initState();
    currentUser = FirebaseAuth.instance.currentUser!.uid;

//search for product id
    searchForProduct();
  }

  int total = 1;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar("تفاصيل المنتج", context),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Center(
                child: Image.network(
                  widget.image,
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
              //-------------------------------------------
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: const AppText(text: "وصف المنتج", fontSize: 20),
                //-----------------------------------------------------------------
              ),
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Wrap(
                  children: [
                    AppText(text: widget.decsription, fontSize: 15),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: AppText(
                    text: "الكمية المتوفرة :  ${int.parse(widget.quantity)}",
                    fontSize: 18),
              ),
              SizedBox(height: 10.h),
              //---------------------------------------------------------------
              Center(
                child: SizedBox(
                  width: 160.w,
                  child: CounterButton(
                    loading: false,
                    onChange: (int val) {
                      setState(() {
                        total = val;
                      });
                    },
                    count: total,
                    countColor: black,
                    buttonColor: green!,
                    progressColor: green!,
                  ),
                ),
              ),
              //--------------------------------------------------------------
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: Center(
                    child: AppText(
                        text:
                            "اجمالي السعر  ${int.parse(widget.price) * total} ريال ",
                        fontSize: 18)),
              ),
              //--------------------------------------------------------------

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Btn(
                  onPressed: () {
                    if (total <= 0) {
                      print("عليك اختيار 1 علي الاقل");
                    } else if (total > int.parse(widget.quantity)) {
                      print("الكمية لاتكفي");
                    } else {
//if item found it will update quantity and price
                      if (x == 1) {
                        cardCollection.doc(docId).update({
                          "total price":
                              dbtotalPrice! + (int.parse(widget.price) * total),
                          "quantity": dbQuantity! + total,
                        }).then((value) {
                          Push.toReplace(
                              context,
                              FarmerProducts(
                                  farmId: widget.farmerId,
                                  farmName: widget.farmName));
                        });
                      } else {
                        FirebaseFirestore.instance.collection("card").add({
                          "prName": widget.pr_name,
                          "total price": int.parse(widget.price) * total,
                          "quantity": total,
                          "prId": widget.pr_id,
                          "userId": currentUser,
                          "farmerId": widget.farmerId,
                          "farmName": widget.farmName,
                          "state": 0
                        }).then((value) {
                          Push.toReplace(
                              context,
                              FarmerProducts(
                                  farmId: widget.farmerId,
                                  farmName: widget.farmName));
                        });
                      }
                    }
                  },
                  title: 'اضافة الي السلة',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchForProduct() {
    cardCollection
        .where('prId', isEqualTo: widget.pr_id)
        .where("state", isEqualTo: 0)
        .get()
        .then((value) {
      setState(() {
        x = value.docs.length;
        for (var element in value.docs) {
          setState(() {
            docId = element.id;
            dbQuantity = element["quantity"];
            dbtotalPrice = element["total price"];
          });
        }
      });
    });
  }
}
