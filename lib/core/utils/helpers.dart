import 'package:flutter/material.dart';

bool isArabic(String text) {
  final arabicRegex = RegExp(r'[\u0600-\u06FF]');
  return arabicRegex.hasMatch(text);
}

TextDirection getTextDirection(String text) {
  return isArabic(text) ? TextDirection.rtl : TextDirection.ltr;
}
