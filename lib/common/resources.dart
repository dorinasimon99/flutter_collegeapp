import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Resources {
  Resources(BuildContext context);
  static CustomColors customColors = CustomColors._();
  static CustomTextStyles customTextStyles = CustomTextStyles._();
}

class CustomColors {
  CustomColors._();
  Color cardGreen = Color(0xFFC7E5C8);
  Color lightGreen = Color(0xFFC3EAC5);
  Color cursorGreen = Color(0xFFB4E7B6);
  Color todoDone = Color(0xFFC9C9C9);
  Color todoGreen = Color(0xFFADCBAD);
  Color todoBackGround = Color(0xFFD7FFD9);
  Color snackBarGreen = Color(0xFFBED7BF);
  Color alertRed = Color(0xFFFF5252);
  Color editCardBackground = Color(0xC6F1D463);
  Color snackBarText = Color(0xFF9A3AFF);
}

class CustomTextStyles{
  CustomTextStyles._();

  TextStyle getCustomTextStyle({String fontFamily = 'Glory', Color color = Colors.black, double fontSize = 16.0}){
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color
    );
  }

  TextStyle getCustomBoldTextStyle({String fontFamily = 'Glory-Semi', Color color = Colors.black, double fontSize = 16.0}){
    return TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: color
    );
  }
}