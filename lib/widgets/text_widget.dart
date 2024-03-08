import 'package:flutter/material.dart';

Widget textWidget({
  required String text,
  color,
  fWeight,
  fSize,
  maxline,
  bool underlined = false,
}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fWeight,
      fontSize: fSize,
      fontFamily: 'Mulish',
      decoration: underlined ? TextDecoration.underline : null,
      decorationColor: Colors.green,
      decorationThickness: 2.0,
    ),
    maxLines: maxline,
  );
}
