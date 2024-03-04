import 'package:flutter/material.dart';

Widget textWidget({required String text, color, fWeight, fSize, maxline}) {
  return Text(
    text,
    style: TextStyle(
      color: color,
      fontWeight: fWeight,
      fontSize: fSize,
      fontFamily: 'Mulish',
    ),
    maxLines: maxline,
  );
}
