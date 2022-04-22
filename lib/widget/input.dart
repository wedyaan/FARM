import 'package:farm/widget/varaible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Colors.dart';

class Input extends StatelessWidget {
  Input({
    Key? key,
    this.controller,
    this.hintText,
    this.isNumberKeyBoard,
    this.onChanged,
    this.validator,
    this.padding,
    this.icon,
    this.max,
    this.min,
    this.inputFormatters,
    this.keyboardType,
  }) : super(key: key);

  //
  final TextEditingController? controller;
  final String? hintText;
  final bool? isNumberKeyBoard;
  final void Function(String)? onChanged;
  String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final int? max;
  final int? min;
  List<TextInputFormatter>? inputFormatters;
  TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: padding,
        child: TextFormField(
          minLines: min ?? 1,
          maxLines: max ?? 1,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              labelText: hintText ?? '',
              labelStyle: TextStyle(fontFamily: "cairo-bold", fontSize: 12.sp),
              suffixIcon: Icon(icon, color: green, size: 20)),
        ),
      ),
    );
  }
}
