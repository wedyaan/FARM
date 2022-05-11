import 'package:farm/screen/FarmerHome/navigator.dart';
import 'package:farm/tools/push.dart';
import 'package:farm/widget/app_text.dart';
import 'package:farm/widget/btn.dart';
import 'package:farm/widget/input.dart';
import 'package:farm/widget/valideMethod.dart';
import 'package:farm/widget/varaible.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widget/showMessage.dart';
import '../AdmainHome/AdmainHome.dart';
import '../UserHome/UserNavigationBar.dart';
import 'register_acount_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> loggingKey = new GlobalKey<FormState>();
  String type = "";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  CollectionReference<Map<String, dynamic>> userCollection =
      FirebaseFirestore.instance.collection("user");
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: loggingKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //logo----------------------------------------------------------------
                  const CircleAvatar(
                    radius: 55.0,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  //تسجيل الدخول----------------------------------------------------------------
                  const AppText(
                    text: 'تسجيل الدخول',
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  const SizedBox(height: 20.0),
                  //تسجيل الدخول----------------------------------------------------------------

                  Input(
                      controller: _emailController,
                      hintText: 'البريد الالكتروني',
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      icon: emailIcon,
                      validator: valedEmile),
                  const SizedBox(height: 10.0),
                  //كلمة المرور ----------------------------------------------------------------

                  Input(
                    controller: _passwordController,
                    hintText: 'كلمة المرور',
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    icon: passIcon,
                    validator: empity,
                    secret: true,
                  ),

                  const SizedBox(height: 20.0),
                  //logging buttom---------------------------------------------------------------

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Btn(
                      onPressed: () async {
                        if (loggingKey.currentState!.validate()) {
                          try {
                            showMessage(context, "", "lode");
                            var userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text)
                                .then((value) async {
                              await userCollection
                                  .where("Emile",
                                      isEqualTo: _emailController.text)
                                  .where("pass",
                                      isEqualTo: _passwordController.text)
                                  .get()
                                  .then((value) {
                                   
                                for (int i = 0; i < value.docs.length; i++) {
                                  if (value.docs[i]["userType"] == "مزارع") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FarmerHome()));
                                  } else if (value.docs[i]["userType"] ==
                                      "مستخدم") {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserNavigationBar()));
                                  } else {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdmainHome()));
                                  }
                                }
                                 
                              });
                              return;
                            });
                          } on FirebaseException catch (e) {
                            //Navigator.pop(context);
                            if (e.code == 'user-not-found') {
                              showMessage(context, "خطا", "المستخدم غير موجود");
                            } else if (e.code == 'wrong-password') {
                              showMessage(context, "خطا", "المستخدم غير موجود");
                            }
                          }
                        }
                      },
                      title: 'تسجيل دخول',
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  //singup buttom---------------------------------------------------------------

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Btn(
                      color: Colors.white,
                      txtColor: Colors.green,
                      onPressed: () {
                        Push.to(context, RegisterAccountPage());
                      },
                      title: 'إنشاء حساب ',
                    ),
                  ),
                  //---------------------------------------------------------------
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
