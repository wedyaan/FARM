// ignore_for_file: file_names, library_prefixes

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../../../widget/Colors.dart';
import '../../../widget/DropMenu.dart';
import '../../../widget/btn.dart';
import '../../../widget/input.dart';
import '../../../widget/method.dart';
import '../../../widget/showMessage.dart';
import '../../../widget/valideMethod.dart';

class UpdateProduts extends StatefulWidget {
  final addId;
  final addimagePath;
  final addprName;
  final addprPrice;
  final addprQuantity;
  final addprCatogary;
  final addprdescription;

  UpdateProduts({this.addId,
    this.addimagePath,
    this.addprName,
    this.addprPrice,
    this.addprQuantity,
    this.addprCatogary,
    this.addprdescription});

  @override
  State<UpdateProduts> createState() => _UpdateProdutsState();
}

class _UpdateProdutsState extends State<UpdateProduts> {
  TextEditingController prName = TextEditingController();
  TextEditingController prPrice = TextEditingController();
  TextEditingController prQuantity = TextEditingController();
  TextEditingController prdescription = TextEditingController();
  TextEditingController prCatogary = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();
  String?isChang = '';

  // File? imagePath;
  String? userId;
  Color color = Colors.transparent;
  String? imageName;
  Reference? imageRef;
  String? imageURL;
  File? fileImage;
  List<String> catogary = ["ورقيات", "خضروات", "تمور", "فواكهة"];

  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
    prName.text = widget.addprName;
    prPrice.text = widget.addprPrice;
    prQuantity.text = widget.addprQuantity;
    isChang = widget.addprCatogary;
    prdescription.text = widget.addprdescription;
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar("تعديل منتج", context),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
//image-----------------------------------------------------------
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    pickImageGallery();
                  },
                  child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: decoration(
                        0,
                        0,
                        20,
                        20,
                        color: green!,
                        blurRadius: 2,
                        border: Border.all(color: color, width: 2),
                      ),
                      child: fileImage != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: Image.file(
                          fileImage!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        child: Image.network(
                          "${widget.addimagePath}",
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.fill,
                        ),
                      )),
                ),
              ),
//textfield-----------------------------------------------------------
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration:
                  decoration(15, 15, 0, 0, color: white, blurRadius: 3),
                  child: SingleChildScrollView(
                    child: Form(
                      key: productKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 15.h),
//name-----------------------------------------------------------
                          Input(
                            validator: empity,
                            controller: prName,
                            hintText: 'اسم المنتج',
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(
                                      r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                                  allow: true)
                            ],
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            icon: Icons.contact_support,
                          ),
                          SizedBox(height: 10.h),
//price-----------------------------------------------------------
                          Input(
                            validator: empity,
                            controller: prPrice,
                            hintText: 'سعر المنتج',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            icon: Icons.attach_money,
                          ),
                          SizedBox(height: 10.h),
//quantity-----------------------------------------------------------
                          Input(
                            validator: empity,
                            controller: prQuantity,
                            hintText: 'الكمية المتوفرة',
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            icon: Icons.production_quantity_limits,
                          ),
                          SizedBox(height: 10.h),
//catogary-----------------------------------------------------------
                          DropMenu(
                            icon: Icons.category,
                            insiValue: isChang,
                            item: catogary,

                            onChangedValue: (selectedItem) {
                              {
                                setState(() {
                                  isChang = selectedItem;
                                });
                              }
                            },
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                          ),
                          SizedBox(height: 10.h),
//description-----------------------------------------------------------
                          Input(
                            validator: empity,
                            controller: prdescription,
                            hintText: 'اضافة وصف',
                            keyboardType: TextInputType.text,
                            inputFormatters: [
                              FilteringTextInputFormatter(
                                  RegExp(
                                      r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                                  allow: true)
                            ],
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            icon: Icons.description,
                            min: 4,
                            max: 4,
                          ),
                          SizedBox(height: 10.h),
//add buttom----------------------------------------------------------------
                          Padding(
                            padding: EdgeInsets.all(10.0.w),
                            child: Btn(
                              color: Colors.green,
                              txtColor: white,
                              onPressed: () async {
                                updateProduct();
                              },
                              title: 'تعديل المنتج ',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //pick Image from Gallery
  pickImageGallery() async {
    var imagepeket = await ImagePicker().getImage(source: ImageSource.gallery);
    if (imagepeket != null) {
      setState(() {
        setState(() {
          color = Colors.transparent;
          fileImage = File(imagepeket.path);
          imageName = Path.basename(imagepeket.path);
          imageRef =
              FirebaseStorage.instance.ref("productImage").child("$imageName");
        });
        color = Colors.transparent;
        //print("image path is ===================${imagepeket.path}");
      });
    }
  }

  Future<void> updateProduct() async {
    try {
      if (productKey.currentState!.validate()) {
        showMessage(context, "تعديل منتج", "lode");
        if (fileImage == null) {
          if (isChang!.isEmpty) {
            await FirebaseFirestore.instance.collection('product').doc(
                widget.addId).update({
              'prName': prName.text,
              'prPrice': prPrice.text,
              'prQuantity': prQuantity.text,
              'prCatogary': widget.addprCatogary,
              'prdescription': prdescription.text,
            }).then((value) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ", "تمت العملية بنجاح");
            }).catchError((e) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ",
                  "هناك مشكلة في الاتصال بقاعدة البيانات");
            });
          } else {
            await FirebaseFirestore.instance.collection('product').doc(
                widget.addId).update({
              'prName': prName.text,
              'prPrice': prPrice.text,
              'prQuantity': prQuantity.text,
              'prCatogary': isChang,
              'prdescription': prdescription.text,
            }).then((value) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ", "تمت العملية بنجاح");
            }).catchError((e) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ",
                  "هناك مشكلة في الاتصال بقاعدة البيانات");
            });
          }
        } else {
          if (isChang!.isEmpty) {
            await imageRef!.putFile(fileImage!);
            imageURL = await imageRef!.getDownloadURL();
            await FirebaseFirestore.instance.collection('productImage').doc(
                widget.addId).update({
              'prName': prName.text,
              'prPrice': prPrice.text,
              'prQuantity': prQuantity.text,
              'prCatogary': widget.addprCatogary,
              'prdescription': prdescription.text,
              'imagePath': imageURL,
            }).then((value) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ", "تمت العملية بنجاح");
            }).catchError((e) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ",
                  "هناك مشكلة في الاتصال بقاعدة البيانات");
            });
          } else {
            await imageRef!.putFile(fileImage!);
            imageURL = await imageRef!.getDownloadURL();
            await FirebaseFirestore.instance.collection('productImage').doc(
                widget.addId).update({
              'prName': prName.text,
              'prPrice': prPrice.text,
              'prQuantity': prQuantity.text,
              'prCatogary': isChang,
              'prdescription': prdescription.text,
              'imagePath': imageURL,
            }).then((value) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ", "تمت العملية بنجاح");
            }).catchError((e) {
              Navigator.pop(context);
              showMessage(context, "تعديل منتج ",
                  "هناك مشكلة في الاتصال بقاعدة البيانات");
            });
          }
        }
      }
    } on FirebaseException catch (e) {
      // ignore: avoid_print
      print("exeption--------------$e");
      throw Exception(e);
    }
  }
}
