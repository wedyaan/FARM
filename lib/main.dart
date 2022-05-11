import 'package:farm/screen/account/loging_page.dart';
import 'package:farm/screen/welcome_scree.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screen/UserHome/UserNavigationBar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenUtilInit(
        designSize: const Size(413, 763),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => MaterialApp(
          title: 'Farm',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: "Cairo",
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.green,
            ),
          ),
          home: WelcomeScreen(),

          //----------------------------------
        ),
      ),
    );
  }
}
