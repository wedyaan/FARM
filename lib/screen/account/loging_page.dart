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

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
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
                      icon: nameIcon,
                      validator: valedEmile
                  ),
                  const SizedBox(height: 10.0),
                  //كلمة المرور ----------------------------------------------------------------

                  Input(
                    controller: _passwordController,
                    hintText: 'كلمة المرور',
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    icon: emailIcon,
                    validator: empity,
                  ),

                  const SizedBox(height: 20.0),
                  //logging buttom---------------------------------------------------------------

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                    child: Btn(
                      onPressed: () {
                        Push.to(context, navHome());
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
                        Navigator.pop(context);
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
