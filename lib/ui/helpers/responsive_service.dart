import 'package:flutter/material.dart';

class ResponsiveService {
  // Singleton
  static final ResponsiveService _instance = ResponsiveService._internal();
  factory ResponsiveService() => _instance;
  ResponsiveService._internal();

  late double screenWidth;
  late double screenHeight;

  // Oranlı hesaplamalar
  double width(double ratio) => screenWidth * ratio;
  double height(double ratio) => screenHeight * ratio;
  double fontSize(double ratio) => screenWidth * ratio; // width bazlı font
}
