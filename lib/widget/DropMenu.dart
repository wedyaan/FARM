import 'package:farm/widget/varaible.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Colors.dart';

class DropMenu extends StatelessWidget {
  const DropMenu(
      {Key? key,
      this.onChangedValue,
      this.validator,
      this.padding,
      this.icon,
      this.item,
      this.insiValue})
      : super(key: key);

  //

  final void Function(String?)? onChangedValue;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;
  final List<String>? item;

  @required
  final String? insiValue;

  //
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: padding,
        child: DropdownButtonFormField<String>(
          validator: validator,

          //elevation: 20,
          hint: Text(
            "$insiValue",
            style: TextStyle(
                fontFamily: "cairo-bold", fontSize: 12.sp, color: textColor),
          ),
          dropdownColor: white,
          icon: Icon(icon, color: green, size: 20),
          items: item!
              .map((type) => DropdownMenuItem(
                    alignment: Alignment.center,
                    value: type,
                    child: Text(
                      type,
                      style: TextStyle(
                        fontFamily: "cairo-bold",
                        fontSize: 12.sp,
                        color: textColor,
                      ),
                    ),
                  ))
              .toList(),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onChanged: onChangedValue,
        ),
      ),
    );
  }
}
/*

;

*/
