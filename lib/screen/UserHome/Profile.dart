import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../tools/push.dart';
import '../../widget/DropMenu.dart';
import '../../widget/app_text.dart';
import '../../widget/btn.dart';
import '../../widget/input.dart';
import '../../widget/method.dart';
import '../../widget/showMessage.dart';
import '../../widget/valideMethod.dart';
import '../../widget/varaible.dart';
import '../account/loging_page.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("user");
  TextEditingController? _userOwnerNameController;
  TextEditingController? _commercialRegisterController;
  TextEditingController? _phoneController;
  TextEditingController? _facilityNameController;
  TextEditingController? _city;

  String? user;
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser!.uid;
    userCollection.where("userID", isEqualTo: user).get().then((value) {
      value.docs.forEach((element) {
        setState(() {
          _userOwnerNameController =
              TextEditingController(text: "${element["ownerName"]}");
          _commercialRegisterController =
              TextEditingController(text: "${element["commercialRegister"]}");
          _phoneController = TextEditingController(text: "${element["phone"]}");
          _facilityNameController =
              TextEditingController(text: "${element["facilityName"]}");
          _city = TextEditingController(text: "${element["city"]}");
        });
      });
    });
  }

  GlobalKey<FormState> singupKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarHome("المعلومات الشخصية", context),
      body: SafeArea(
        child: Form(
          key: singupKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
//iprofile image----------------------------------------------------------------
                _headerProfile(),
                const AppText(
                  text: "الصورة الشخصية",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                const SizedBox(height: 20.0),

//name textField----------------------------------------------------------------
                Input(
                    controller: _userOwnerNameController,
                    hintText: 'اسم المالك',
                    icon: nameIcon,
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                          RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                          allow: true)
                    ],
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: empity),
                SizedBox(height: 10.0.h),

//السجل التجاري ----------------------------------------------------------------
                Input(
                    controller: _commercialRegisterController,
                    hintText: 'السجل التجاري',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    icon: recordIcon,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: commercialRegister),

                SizedBox(height: 10.0.h),

//اسم المنشاة textField----------------------------------------------------------------
                Input(
                    controller: _facilityNameController,
                    hintText: 'اسم المنشاة',
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                          RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                          allow: true)
                    ],
                    icon: buildName,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: empity),
                SizedBox(height: 10.0.h),
//city textField----------------------------------------------------------------

                Input(
                    controller: _city,
                    hintText: 'المدينة',
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter(
                          RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                          allow: true)
                    ],
                    icon: city,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: empity),
                SizedBox(height: 10.0.h),
//phone textField----------------------------------------------------------------

                Input(
                    controller: _phoneController,
                    hintText: 'رقم الجوال',
                    keyboardType: TextInputType.phone,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    icon: phoneIcon,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: phone),
                SizedBox(height: 10.0.h),

//update buttom----------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Btn(
                    onPressed: () {},
                    title: 'تعديل البيانات',
                  ),
                ),

                SizedBox(height: 10.0.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

//-----------------------------------------------------------------------------------------
  InkWell _headerProfile() {
    return InkWell(
      onTap: () {},
      child: Stack(
        clipBehavior: Clip.none,
        children: [
//image===========================
          CircleAvatar(
            radius: 55.0,
            backgroundImage: AssetImage(
              'assets/images/profile.png',
            ),
          ),
//icon===========================
          Positioned(
              top: 80.0.h,
              right: 95.0.w,
              child: Icon(Icons.add_a_photo, size: 37.sp, color: Colors.red)),
        ],
      ),
    );
  }

//update buttom----------------------------------------------------------------

  singUpUser(String ownerName, String commercialRegister, String facilityName,
      String city, String phone, String userType) async {
    if (singupKey.currentState!.validate()) {
      showMessage(context, "انشاء حساب", "lode");

      await FirebaseFirestore.instance.collection('user').add({
        'userType': userType,
        'ownerName': ownerName,
        'city': city,
        'commercialRegister': commercialRegister,
        'facilityName': facilityName,
        'phone': phone
      }).then((value) {
        //Navigator.pop(context);
        showMessage(context, "انشاء حساب مستخدم", "تمت العملية بنجاح");
      }).catchError((e) {
        //Navigator.pop(context);
        showMessage(context, "انشاء حساب مستخدم",
            "هناك مشكلة في الاتصال بقاعدة البيانات");
      });
    }
  }
}
