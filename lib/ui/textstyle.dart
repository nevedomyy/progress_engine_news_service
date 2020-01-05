import 'package:flutter/material.dart';
import 'color.dart';


class AppTextStyle{
  static TextStyle get menuItems => TextStyle(color: Colors.grey, fontSize: 24.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get enter => TextStyle(color: AppColor.red, fontSize: 20.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get btn => TextStyle(color: AppColor.black2, fontSize: 20.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get registration => TextStyle(color: Colors.grey, fontSize: 16.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get title => TextStyle(color: AppColor.black2, fontSize: 30.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get error => TextStyle(color: AppColor.red, fontSize: 16.0, fontFamily: 'OpenSans-Regular');
  static TextStyle get login => TextStyle(color: AppColor.red, fontSize: 18.0, fontFamily: 'PlayfairDisplay-Regular');
  static TextStyle get header => TextStyle(color: AppColor.black2, fontSize: 16.0, fontFamily: 'OpenSans-Regular');
  static TextStyle get headerBold => TextStyle(color: AppColor.black2, fontSize: 16.0, fontWeight: FontWeight.bold, fontFamily: 'OpenSans-Regular');
  static TextStyle get text => TextStyle(color: AppColor.black2, fontSize: 14.0, fontFamily: 'OpenSans-Regular');
  static TextStyle get textField => TextStyle(color: AppColor.black2, fontSize: 16.0, fontFamily: 'OpenSans-Regular');
}