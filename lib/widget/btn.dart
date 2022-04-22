import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Btn extends StatelessWidget {
  const Btn({
    Key? key,
    this.onPressed,
    this.title,
    this.color,
    this.txtColor,
    this.width,
  }) : super(key: key);

  //
  final void Function()? onPressed;
  final String? title;
  final Color? color;
  final Color? txtColor;
  final double? width;

  //
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: MaterialButton(
        color: color ?? Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0.r),
        ),
        onPressed: onPressed,
        child: Text(
          title ?? 'title',
          style: TextStyle(
            color: txtColor ?? Colors.white,
            fontFamily: 'cairo-bold',
          ),
        ),
      ),
    );
  }
}
