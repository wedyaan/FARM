import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/widget/DropMenu.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/showMessage.dart';
import 'package:farm/widget/valideMethod.dart';
import 'package:farm/widget/varaible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import 'loging_page.dart';

class RegisterAccountPage extends StatefulWidget {
  const RegisterAccountPage({Key? key, this.isShowAppBar}) : super(key: key);

  ///
  final bool? isShowAppBar;

  @override
  State<RegisterAccountPage> createState() => _RegisterAccountPageState();
}

class _RegisterAccountPageState extends State<RegisterAccountPage> {
  final TextEditingController _userOwnerNameController =
  TextEditingController();
  final TextEditingController _commercialRegisterController =
  TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController auth = TextEditingController();
  final TextEditingController _agriculturalRegistryController =
  TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _facilityNameController = TextEditingController();
  final TextEditingController _city = TextEditingController();
  GlobalKey<FormState> singupKey =  GlobalKey<FormState>();

  bool showUserRecord = false;
  bool showFarmRecord = true;
  bool visibleEmail = true;
  bool visiblePassword = true;
  String? user = '';

  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _map = Map<String, dynamic>();

  ///
  @override
  Widget build(BuildContext context) {
    List<String> userType = ["مزارع", "مستخدم"];
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: singupKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 60.h),
//iprofile image----------------------------------------------------------------
                _headerProfile(),
                AppText(
                  text: showFarmRecord == true
                      ? "انشاء حساب مستخدم"
                      : "انشاء حساب مزراع",
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                const SizedBox(height: 20.0),
//usertype-----------------------------------------------------------
                DropMenu(
                  icon: Icons.category,
                  insiValue: "نوع المستخدم",
                  item: userType,
                  validator: (value) {
                    if (value == null) {
                      return "اختر نوع المستخدم";
                    } else {
                      return null;
                    }
                  },
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  onChangedValue: (selectedItem) {
                    if (selectedItem == "مزارع") {
                      user = "مزارع";

                      setState(() {
                        showUserRecord = true;
                        showFarmRecord = false;
                      });
                    } else {
                      user = "مستخدم";
                      setState(() {
                        showUserRecord = false;
                        showFarmRecord = true;
                      });
                    }
                  },
                ),
                SizedBox(height: 10.0.h),
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

//email textField----------------------------------------------------------------

                Input(
                    controller: _emailController,
                    hintText: 'الايميل',
                    icon: emailIcon,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: valedEmile),
                SizedBox(height: 10.0.h),

//pass textField----------------------------------------------------------------
                Input(
                    controller: _passwordController,
                    hintText: 'كلمة المرور',
                    icon: showPassIcon,
                    secret: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: empity),
                SizedBox(height: 10.0.h),
//-------------------------------------------------------------------------------------------
//السجل الزراعي textField----------------------------------------------------------------
                Visibility(
                  visible: showUserRecord,
                  child: Input(
                      controller: _agriculturalRegistryController,
                      hintText: 'السجل الزراعي',
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      icon: recordIcon,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      validator: agriculturalRegistry),
                ),
                Visibility(
                    visible: showUserRecord, child: SizedBox(height: 10.0.h)),

//اسم المزرعة textField----------------------------------------------------------------
                Visibility(
                  visible: showUserRecord,
                  child: Input(
                      controller: _farmNameController,
                      hintText: 'اسم المزرعة',
                      icon: buildName,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        FilteringTextInputFormatter(
                            RegExp(r'[a-zA-Z]|[أ-ي]|[ؤ-ئ-لا-لأ-]|[ء]|[ ]'),
                            allow: true)
                      ],
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      validator: empity),
                ),
                Visibility(
                    visible: showUserRecord, child: SizedBox(height: 10.0.h)),

//-------------------------------------------------------------------------------------------
//السجل التجاري textField----------------------------------------------------------------
                Visibility(
                  visible: showFarmRecord,
                  child: Input(
                      controller: _commercialRegisterController,
                      hintText: 'السجل التجاري',
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      icon: recordIcon,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      validator: commercialRegister),
                ),

                Visibility(
                    visible: showFarmRecord, child: SizedBox(height: 10.0.h)),

//اسم المنشاة textField----------------------------------------------------------------
                Visibility(
                  //uuuuu
                  visible: showFarmRecord,
                  child: Input(
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
                ),
                Visibility(
                    visible: showFarmRecord, child: SizedBox(height: 10.0.h)),
//------------------------------------------------------------------------------------------------
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
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    icon: phoneIcon,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    validator: phone),
                SizedBox(height: 10.0.h),

//sing up buttom ----------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Btn(
                    onPressed: () {
                      if (user == "مزارع") {
                        singUpFarm(
                            _emailController.text,
                            _userOwnerNameController.text,
                            _passwordController.text,
                            _agriculturalRegistryController.text,
                            _farmNameController.text,
                            _city.text,
                            _phoneController.text,
                            "مزارع");
                      } else {
                        singUpUser(
                            _emailController.text,
                            _userOwnerNameController.text,
                            _passwordController.text,
                            _commercialRegisterController.text,
                            _facilityNameController.text,
                            _city.text,
                            _phoneController.text,
                            "مستخدم");
                      }
                    },
                    title: 'التسجيل بالتطبيق',
                  ),
                ),

                SizedBox(height: 10.0.h),

//logging buttom----------------------------------------------------------------
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                  child: Btn(
                    color: Colors.white,
                    onPressed: () {
                      Push.to(context, const LoginPage());
                    },
                    title: 'تسجيل دخول',
                    txtColor: Colors.green,
                  ),
                ),
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
        children: const [
//image===========================
          CircleAvatar(
            radius: 55.0,
            backgroundImage: AssetImage(
              'assets/images/profile.png',
            ),
          ),
//icon===========================
        ],
      ),
    );
  }

//register new farm ----------------------------------------------------
  singUpFarm(String email,
      String ownerName,
      String pass,
      String agriculturalRegistry,
      String farmName,
      String city,
      String phone,
      String userType) async {
    if (singupKey.currentState!.validate()) {
      try {
        showMessage(context, "انشاء حساب", "lode");

        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: pass,
        );
        final userID = userCredential.user?.uid;

        if (userID != null) {
          User? currentUser = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance.collection('user').add({
            "userID": currentUser!.uid,
            'userType': userType,
            'Emile': email,
            'pass': pass,
            'ownerName': ownerName,
            'city': city,
            'agriculturalRegistry': agriculturalRegistry,
            'farmName': farmName,
            'phone': phone
          }).then((value) {
            //Navigator.pop(context);
            showMessage(context, "انشاء حساب مزارع", "تمت العملية بنجاح");
          }).catchError((e) {
            //Navigator.pop(context);
            showMessage(context, "انشاء حساب مزارع",
                "هناك مشكلة في الاتصال بقاعدة البيانات");
          });
        } else {
          //Navigator.pop(context);
          showMessage(context, "انشاء حساب مزارع", "فشلت عملية انشاء الحساب");
        }
      } on FirebaseAuthException catch (e) {
        //Navigator.pop(context);
        if (e.code == 'weak-password') {
          showMessage(context, "انشاء حساب مزارع",
              "يجب ان تكون كلمة السر 6 احرف علي الاقل");
        }
        if (e.code == 'email-already-in-use') {
          showMessage(
              context, "انشاء حساب مزارع", "البريد الالكتروني مستخدم بالفعل");
        }
      } catch (e) {
        showMessage(context, "انشاء حساب مزارع", e.toString());
      }
    }
  }

  //=======================================================================================================
  //register new user----------------------------------------------------
  singUpUser(String email,
      String ownerName,
      String pass,
      String commercialRegister,
      String facilityName,
      String city,
      String phone,
      String userType) async {
    if (singupKey.currentState!.validate()) {
      try {
        showMessage(context, "انشاء حساب", "lode");
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.trim(),
          password: pass,
        );
        final userID = userCredential.user?.uid;

        if (userID != null) {
          User? currentUser = FirebaseAuth.instance.currentUser;
          await FirebaseFirestore.instance.collection('user').add({
            "userID": currentUser!.uid,
            'userType': userType,
            'Emile': email,
            'pass': pass,
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
        } else {
          // Navigator.pop(context);
          showMessage(
            context,
            "انشاء حساب مستخدم",
            "فشلت عملية انشاء الحساب",
          );
        }
      } on FirebaseAuthException catch (e) {
        //Navigator.pop(context);
        if (e.code == 'weak-password') {
          showMessage(context, "انشاء حساب مستخدم",
              "يجب ان تكون كلمة السر 6 احرف علي الاقل");
        }
        if (e.code == 'email-already-in-use') {
          showMessage(
            context,
            "انشاء حساب مستخدم",
            "البريد الالكتروني مستخدم بالفعل",
          );
        }
      } catch (e) {
        showMessage(context, "انشاء حساب مستخدم", e.toString());
      }
    }
  }
}
