import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'Colors.dart';

//divider--------------------------------------

divider({
  double thickness = 2,
  double indent = 15,
  double endIndent = 15,
}) {
  return Align(
    alignment: Alignment.topCenter,
    child: VerticalDivider(
      color: Colors.grey[400],
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      //width: 12,
    ),
  );
}

//app bar --------------------------------------
appBar(String title, BuildContext context, {icone, void Function()? on_Tap}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 22.sp, fontFamily: 'cairo-bold', color: black),
    ),
    centerTitle: true,
    leading: IconButton(
      padding: EdgeInsets.only(right: 20.w),
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.black,
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    actions: [
      icone == null
          ? const Icon(Icons.add, size: 0)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: InkWell(
                onTap: on_Tap,
                child: Icon(
                  icone!,
                  size: 30.sp,
                  color: green,
                ),
              ),
            )
    ],
    backgroundColor: deepwhite,
    elevation: 0,
  );
}
//--------------------------------------------------------
badgetAppBar(String title, BuildContext context, {badgeIcon}) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 22.sp, fontFamily: 'cairo-bold', color: black),
    ),
    centerTitle: true,
    leading: IconButton(
      padding: EdgeInsets.only(right: 20.w),
      icon: const Icon(Icons.arrow_back_ios),
      color: Colors.black,
      onPressed: () {
        Navigator.maybePop(context);
      },
    ),
    actions: [
      badgeIcon == null
          ? const Icon(Icons.add, size: 0)
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0.w),
              child: badgeIcon)
    ],
    backgroundColor: deepwhite,
    elevation: 0,
  );
}
//----------------------------------------------------------
//app bar --------------------------------------
appBarHome(String title, BuildContext context) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 21.sp, fontFamily: 'cairo-bold', color: white),
    ),
    centerTitle: true,
    leading: Text(""),
    backgroundColor: green,
    elevation: 0,
  );
}

//container decoration-------------------------------------------
decoration(
  double bottomLeft,
  double bottomRight,
  double topLeft,
  double topRight, {
  Color color = deepwhite,
  double blurRadius = 0.0,
  double spreadRadius = 0.0,
  BoxBorder? border,
 
}) {
  return BoxDecoration(
  //
    color: color,
    border: border,
    
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ],
  );
}

//container decoration-------------------------------------------
decorationImage(
  double bottomLeft,
  double bottomRight,
  double topLeft,
  double topRight, {
  Color color = deepwhite,
  double blurRadius = 0.0,
  double spreadRadius = 0.0,
  BoxBorder? border,
  String ?image
}) {
  return BoxDecoration(
  //
    color: color,
    border: border,
    image:DecorationImage(image: AssetImage(image!),fit: BoxFit.cover),
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(topLeft.r),
      topRight: Radius.circular(topRight.r),
      bottomLeft: Radius.circular(bottomLeft.r),
      bottomRight: Radius.circular(bottomRight.r),
    ),
    boxShadow: [
      BoxShadow(
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      )
    ],
  );
}
int unidID() {
  return DateTime.now().millisecondsSinceEpoch.remainder(10000);
}

int orderNumber() {
  return DateTime.now().millisecondsSinceEpoch.remainder(10000000);
}
