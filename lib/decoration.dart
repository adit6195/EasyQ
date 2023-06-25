import 'package:flutter/material.dart';

class ColorPalatte {
  static Color primaryColor = Color(0xff3B4948);
  static Color secondaryColor = Color(0xff14bef0);
  static Color darkColor = Color(0xff2D2D32);

  // static Color primaryColorAccent = Color.fromRGBO(8, 44, 108, 0.5);

  // static Color primaryColor = Color(0xff262833);
  // static Color primaryColorAccent = Color(0xff262833).withOpacity(0.9);
  // static List<Color> buttonGradient = [primaryColor, primaryColorAccent];

  // static Color primaryColor = Color.fromRGBO(69, 193, 99, 1);
}

class Soft {
  double? color;
  var backcolor;

  Soft({
    this.backcolor,
    this.color,
  });

  static BoxDecoration soft0 = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      // color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 19.0,
            spreadRadius: 0.0)
      ]);

  // static BoxDecoration soft = BoxDecoration(
  //     borderRadius: BorderRadius.circular(8),
  //     color: ColorPlatte.third,
  //     // color: Colors.white,
  //     boxShadow: [
  //       BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 19.0,
  //           spreadRadius: 0.0)
  //     ]);

  // static BoxDecoration soft2 = BoxDecoration(
  //     borderRadius: BorderRadius.circular(8),
  //     color: ColorPlatte.third2,
  //     // color: Colors.white,
  //     boxShadow: [
  //       BoxShadow(
  //           color: Colors.black.withOpacity(0.1),
  //           blurRadius: 19.0,
  //           spreadRadius: 0.0)
  //     ]);

  static BoxDecoration soft3 = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: ColorPalatte.secondaryColor,
      // color: Colors.white,
      boxShadow: [
        BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 19.0,
            spreadRadius: 0.0)
      ]);
}
