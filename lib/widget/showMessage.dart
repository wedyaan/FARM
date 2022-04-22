// ignore_for_file: deprecated_member_use

import 'package:farm/widget/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import 'Colors.dart';
import 'btn.dart';

showMessage(context, String title, String content,
    {bool showButtom = false,
    void Function()? yesFunction,
    void Function()? noFunction}) {
  return showDialog(
      //barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(40.0))),
          titlePadding: EdgeInsets.zero,
          elevation: 0,

          backgroundColor: content == "lode" ? Colors.transparent : white,

//tittle-------------------------------------------------------------------

          title: content != "lode"
              ? Container(
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r))),
                  width: double.infinity,
                  height: 50,
                  child: Center(
                      child: AppText(
                          text: title,
                          fontSize: 14,
                          color: white,
                          fontWeight: FontWeight.bold)),
                )
              : const SizedBox(),
//continent area-------------------------------------------------------------------

          content: content != "lode"
              ? SizedBox(
                  height: 100.h,
                  width: double.infinity,
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
//continent tittle-------------------------------------------------------------------
                      Expanded(
                        flex: 3,
                        child: Center(
                            child: AppText(
                          text: content,
                          fontSize: 14,
                          color: black,
                          textAlign: TextAlign.right
                        )),
                      ),

//divider-------------------------------------------------------------------

                      showButtom
                          ? Divider(
                              thickness: 2,
                              color: gry,
                            )
                          : const SizedBox(),
                      SizedBox(height: 10.h),
//bottoms-------------------------------------------------------------------

                      showButtom
                          ? Expanded(
                              flex: 1,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
// yes bottoms-------------------------------------------------------------------

                                    Expanded(
                                      child: Btn(
                                        color: Colors.green,
                                        onPressed: yesFunction,
                                        title: 'نعم',
                                        txtColor: Colors.white,
                                      ),
                                    ),

                                    SizedBox(width: 20.w),
//no buttom-------------------------------------------------------------------
                                    Expanded(
                                      child: Btn(
                                        color: Colors.green,
                                        onPressed: noFunction,
                                        title: 'لا',
                                        txtColor: Colors.white,
                                      ),
                                    )
                                  ]),
                            )
                          : const SizedBox(),
                    ],
                  ))
//Show Waiting image-------------------------------------------------------
              : SizedBox(
                  width: double.infinity,
                  height: 150.h,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Lottie.asset(
                      "assets/icons/lode.json",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

//Show bottoms -------------------------------------------------------

          actions: [
            showButtom == false && content != "lode"
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            Navigator.of(context).pop(true);
                          },
                          icon: Icon(Icons.delete_outline,
                              color: green, size: 35.sp)),
                    ),
                  )
                : const SizedBox()
          ],
        );
      });
}

showMessageBottom(
    context,
    String titleText,
    String cotentText,
    void Function()? yesFunction,
    String okText,
    String cancelText,
    Function()? noFunction) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: AppText(
          color: black,
          fontSize: 16,
          textAlign: TextAlign.center,
          text: titleText,
        ),
        content: AppText(
            color: black,
            fontSize: 14,
            textAlign: TextAlign.center,
            text: cotentText),
        actions: [
          FlatButton(
            onPressed: yesFunction,
            child: AppText(
                color: green!,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                text: okText),
          ),
          FlatButton(
            onPressed: noFunction,
            child: AppText(
                color: black,
                fontSize: 12,
                //fontWeight: FontWeight.bold,
                text: cancelText),
          ),
        ],
      );
    },
  );
}
