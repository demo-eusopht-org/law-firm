import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  Color? color,
  FontWeight? fWeight,
  double? fSize,
  int? maxline,
  bool underlined = false,
  TextAlign? textAlign,
  double? letterSpacing,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fWeight,
      letterSpacing: letterSpacing,
      fontSize: fSize,
      fontFamily: 'Mulish',
      decoration: underlined ? TextDecoration.underline : null,
      decorationColor: Colors.green,
      decorationThickness: 2.0,
    ),
    textAlign: textAlign,
    maxLines: maxline,
  );
}
