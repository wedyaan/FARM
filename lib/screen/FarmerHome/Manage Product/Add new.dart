import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/widget/Colors.dart';
import 'package:farm/widget/DropMenu.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/method.dart';
import 'package:farm/widget/showMessage.dart';
import 'package:farm/widget/valideMethod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class AddNewProduct extends StatefulWidget {
  AddNewProduct({Key? key}) : super(key: key);

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController prName = TextEditingController();
  final TextEditingController prPrice = TextEditingController();
  final TextEditingController prQuantity = TextEditingController();
  final TextEditingController prdescription = TextEditingController();
  final TextEditingController prCatogary = TextEditingController();
  GlobalKey<FormState> productKey = GlobalKey<FormState>();

  // File? imagePath;
  String? userId;
  Color color = Colors.transparent;
  String?imageName;
  Reference? imageRef;
  String? imageURL;
  File? fileImage;


  @override
  void initState() {
    super.initState();
    userId = FirebaseAuth.instance.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    List<String> catogary = ["ورقيات", "خضروات", "تمور", "فواكهة"];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: appBar("اضافة منتج جديد", context),
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
                        : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.image,
                            color: white,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          const AppText(
                            text: "صورة المنتج",
                            color: white,
                          )
                        ]),
                  ),
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
                              FilteringTextInputFormatter(RegExp(
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
                            insiValue: "اختر التصنيف",
                            item: catogary,
                            validator: (value) {
                              if (value == null) {
                                return "اختر التصنيف";
                              } else {
                                return null;
                              }
                            },
                            onChangedValue: (selectedItem) {
                              {
                                setState(() {
                                  prCatogary.text = selectedItem!;
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
                              FilteringTextInputFormatter(RegExp(
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
                                addProduct();
                              },
                              title: 'اضافة المنتج ',
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

  Future<void> addProduct() async {
    if (fileImage == null) {
      setState(() {
        color = Colors.red;
      });
    } else if (productKey.currentState!.validate() && fileImage != null) {
      showMessage(context, "اضافة منتج", "lode");
      setState(() {
        color = Colors.transparent;
      });

      await imageRef!.putFile(fileImage!);
      imageURL = await imageRef!.getDownloadURL();
      await FirebaseFirestore.instance.collection('product').add({
        "userID": userId,
        'prName': prName.text,
        'prPrice': int.parse(prPrice.text),
        'prQuantity': int.parse(prQuantity.text),
        'prCatogary': prCatogary.text,
        'prdescription': prdescription.text,
        'imagePath': imageURL,
        "productID": unidID(),


      }).then((value) {
        Navigator.pop(context);
        showMessage(context, "اضافةمنتج ", "تمت العملية بنجاح");
      }).catchError((e) {
        Navigator.pop(context);
        showMessage(context, "اضافة منتج ",
            "هناك مشكلة في الاتصال بقاعدة البيانات");
      });
    }
  }
}
