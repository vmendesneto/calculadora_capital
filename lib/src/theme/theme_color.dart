import 'package:flutter/material.dart';

import '../controller/state_view.dart';

enum kdataFetchState { IS_LOADING, IS_LOADED, ERROR_ENCOUNTERED }

const Color lightThemePrimaryColor = Color(0xffFFFFFF);
const Color lightThemePrimaryColorDark = Color(0xffE5EBF0);
const Color lightThemeAccentColor = Color(0xff00115B);
const Color lightThemeButtonColor = Color(0xff00115B);
const Color lightThemeCardColor = Color(0xff34609F);
const Color lightThemeResetColor = Color(0xffadb6c6);


const Color darkThemePrimaryColor = Color(0xff171919);
const Color darkThemePrimaryColorDark = Color(0xff2B2B2B);
const Color darkThemeAccentColor = Color(0xff00115B);
const Color darkThemeButtonColor = Color(0xff00115B);
const Color darkThemeCardColor = Color(0xff34609F);




final List<ThemeData> themes = [lightTheme, darkTheme];

const List<Color> cardColors = [
  Color(0xffadb6c6),
  Color(0xff963e63),
  Color(0xffe6a542),
  Color(0xff519b89),
  Color(0xffab8c67),
  Color(0xffde34a0),
  Color(0xff082555),//azul safira
  Color(0xfff4663c),
  Color(0xffa9c95a),
];

final darkTheme = ThemeData(
  primaryColor: darkThemePrimaryColor,
  primaryColorDark: darkThemePrimaryColorDark,
  indicatorColor: darkThemeButtonColor,
  buttonColor: darkThemeButtonColor,
  accentColor: darkThemeAccentColor,
  hoverColor: darkThemeAccentColor,
  //cardColor: darkThemeCardColor,
  unselectedWidgetColor: darkThemeCardColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: const IconThemeData(color: Colors.white),
  textTheme: TextTheme(
    headline4: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 14 :variables.width! > 350 ? 9:variables.width! > 300 ? 8 :variables.width! > 200 ? 7 : 5),
        //fontSize: 14),
    headline5: TextStyle(
        fontFamily: 'FuturaPTBook.otf',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 16 : variables.width! > 350 ? 12 :variables.width! > 300 ? 11 :variables.width! > 200 ? 10 : 7),
        //fontSize: 16),
    headline6: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w800,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 8 : variables.width! > 350 ? 6:variables.width! > 300 ? 5 :variables.width! > 200 ? 3 : 2),
        //fontSize: 8
    headline1: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 20 :variables.width! > 350 ? 14:variables.width! > 300 ? 12 : variables.width! > 200 ? 11 : 7),
        //fontSize: 20),
    subtitle1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 25 : variables.width! > 350 ? 19:variables.width! > 300 ? 14 :variables.width! > 200 ? 8 : 6),
       // fontSize: 25),
    bodyText2: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 12 : variables.width! > 350 ? 9:variables.width! > 300 ? 8 :variables.width! > 200 ? 7 : 6),
        //fontSize: 12),
    bodyText1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 10 : variables.width! > 350 ? 6:variables.width! > 300 ? 5 :variables.width! > 200 ? 4 : 2),
        //fontSize: 8),
    subtitle2: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 20 :variables.width! > 350 ? 15:variables.width! > 300 ? 12 :variables.width! > 200 ? 15 : 10),
      // fontSize: 20),
    caption: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 25 :variables.width! > 350 ? 19:variables.width! > 300 ? 12 :variables.width! > 200 ? 15 : 10),
        //fontSize: 25),
    button: TextStyle(
      fontFamily: 'FuturaPTBold.otf',
      fontWeight: FontWeight.w700,
      color: Colors.lightBlue,
        fontSize: variables.width! > 400 ? 25 : variables.width! > 350 ? 19: variables.width! > 300 ? 12 : variables.width! > 200 ? 15 : 10),
  ),
);

final lightTheme = ThemeData(
  unselectedWidgetColor: lightThemeCardColor,
  primaryColorDark: lightThemePrimaryColorDark,
  primaryColor: lightThemePrimaryColor,
  buttonColor: lightThemeButtonColor,
  indicatorColor: lightThemeButtonColor,
  accentColor: lightThemeAccentColor,
  hoverColor: lightThemeAccentColor,
  //cardColor: lightThemeCardColor,
  canvasColor: Colors.transparent,
  primaryIconTheme: const IconThemeData(color: Colors.black),
  textTheme: TextTheme(
    headline4: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 14 :variables.width! > 350 ? 9:variables.width! > 300 ? 8 :variables.width! > 200 ? 7 : 5),
    headline5: TextStyle(
        fontFamily: 'FuturaPTBook.otf',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 16 : variables.width! > 350 ? 12 :variables.width! > 300 ? 11 :variables.width! > 200 ? 10 : 7),
    headline6: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w800,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 8 : variables.width! > 350 ? 6:variables.width! > 300 ? 5 :variables.width! > 200 ? 3 : 2),
    headline1: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 20 :variables.width! > 350 ? 14:variables.width! > 300 ? 12 : variables.width! > 200 ? 11 : 7),
    subtitle1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 25 : variables.width! > 350 ? 19:variables.width! > 300 ? 14 :variables.width! > 200 ? 8 : 6),
    bodyText2: TextStyle(
        fontFamily: 'FuturaPTMedium.otf',
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 12 : variables.width! > 350 ? 9:variables.width! > 300 ? 8 :variables.width! > 200 ? 7 : 6),
    bodyText1: TextStyle(
        fontFamily: 'FuturaPTLight.otf',
        fontWeight: FontWeight.w400,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 10 : variables.width! > 350 ? 6:variables.width! > 300 ? 5 :variables.width! > 200 ? 4 : 2),
    subtitle2: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.black,
        fontSize: variables.width! > 400 ? 20 :variables.width! > 350 ? 15:variables.width! > 300 ? 12 :variables.width! > 200 ? 15 : 10),
    caption: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.white,
        fontSize: variables.width! > 400 ? 25 :variables.width! > 350 ? 19:variables.width! > 300 ? 12 :variables.width! > 200 ? 15 : 10),
    button: TextStyle(
        fontFamily: 'FuturaPTBold.otf',
        fontWeight: FontWeight.w700,
        color: Colors.lightBlue,
        fontSize: variables.width! > 400 ? 25 : variables.width! > 350 ? 19: variables.width! > 300 ? 12 : variables.width! > 200 ? 15 : 10),
  ),
);
