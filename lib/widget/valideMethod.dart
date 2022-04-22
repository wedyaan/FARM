// ignore_for_file: file_names

import 'package:email_validator/email_validator.dart';

String? empity(value) {
  if (value.isEmpty) {
    return value = value + "\n" + "املء الحقل اعلاه";
  }
  return null;
}

//التحقق من صحه الايميل المدخل
// ignore: missing_return
String? valedEmile(value) {
  if (value.trim().isEmpty) {
    return "املء الحقل اعلاه";
  }

  if (EmailValidator.validate(value.trim()) == false) {
    return "البريد الالكتروني غير صالح";
  }
  return null;
}

//التحقق من صحه الرقم المدخل
// ignore: missing_return
String? phone(value) {
  if (value.isEmpty) {
    return "املء الحقل اعلاه";
  }
  if (value.length < 10 || value.length > 10) {
    return 'رقم الهاتف يجب ان يكون 10 ارقام';
  }
  if (!value.startsWith('05')) {
    return 'يجب ان يبدا رقم الهاتف ب 05';
  }
  return null;
}

// التحقق من السجل التجاري
String? commercialRegister(value) {
  if (value.isEmpty) {
    return "املء الحقل اعلاه";
  }
  if (value.length < 10 || value.length > 10) {
    return 'يرجى إدخال رقم السجل التجاري بصورة صحيحة';
  }

  return null;
}

// التحقق من السجل الزراعي
String? agriculturalRegistry(value) {
  if (value.isEmpty) {
    return "املء الحقل اعلاه";
  }
  if (value.length < 10 || value.length > 10) {
    return 'يرجى إدخال رقم السجل الزراعي بصورة صحيحة';
  }

  return null;
}
