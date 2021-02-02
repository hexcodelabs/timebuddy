import 'package:flutter/material.dart';
import 'color/colors.dart';

class AppTheme {
  const AppTheme();
  static ThemeData perksTheme = ThemeData(
    primaryColor: PerksColor.grey,
    primaryColorDark: PerksColor.Darker,
    primaryColorLight: PerksColor.brighter,
    accentColor: PerksColor.logoColor,
    dividerColor: PerksColor.lightGrey,
    fontFamily: 'Gilroy',
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  //Colors
  static const Color mainGreen = Color(0xff0eac7c);
  static const Color darkgrey = Color(0xff040405);
  static const Color creditCardBackground = Color(0xff384be7);
  static const Color lightGrey = Color(0xffd6d6d6);
  static const Color bookedTagColor = Color(0xff1DB26B);
  static const Color cancelledTagColor = Color(0xfff84646);
  static const Color pendingTagColor = Color(0xffffbd14);

  static TextStyle logoTitle = const TextStyle(
      color: PerksColor.logoColor,
      fontSize: 46,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle topic = const TextStyle(
      color: PerksColor.titleTextColor,
      fontSize: 23,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy',
      letterSpacing: 1);
  static TextStyle mainTitle = const TextStyle(
      color: PerksColor.titleTextColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle titleStyle = const TextStyle(
      color: PerksColor.titleTextColor,
      fontSize: 18,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');
  static TextStyle subTitleStyle = const TextStyle(
      color: PerksColor.darkgrey,
      fontSize: 13,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');
  static TextStyle subTitleStyleBold = const TextStyle(
      color: PerksColor.darkgrey,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle subTitleStyleBoldBlack = const TextStyle(
      color: Colors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle appBarTitle = const TextStyle(
      color: PerksColor.titleTextColor,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle appBarTitleLight = const TextStyle(
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'Gilroy');
  static TextStyle textField = const TextStyle(
      color: PerksColor.black,
      fontSize: 17,
      fontFamily: 'Gilroy',
      letterSpacing: 1);
  static TextStyle textFieldSearch = const TextStyle(
      color: PerksColor.black, fontSize: 20, fontFamily: 'Gilroy');
  static TextStyle textFieldLabel = const TextStyle(
      color: PerksColor.grey,
      fontSize: 15,
      letterSpacing: 0,
      fontFamily: 'Gilroy');
  static TextStyle textFieldPassword = const TextStyle(
      color: PerksColor.black,
      fontSize: 16,
      letterSpacing: 5,
      fontFamily: 'Gilroy');
  static TextStyle errorTextField = const TextStyle(
      color: PerksColor.red, fontSize: 10, fontFamily: 'Gilroy');

  static TextStyle description = const TextStyle(
      color: PerksColor.grey,
      fontSize: 15,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');

  static TextStyle pinCode = const TextStyle(
      color: PerksColor.black,
      fontSize: 25,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');

  static TextStyle redText = const TextStyle(
      color: PerksColor.red,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');

  static TextStyle tagText = const TextStyle(
      color: Colors.white,
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontFamily: 'Gilroy');

  static const screenSizeFactor = 1;
}
