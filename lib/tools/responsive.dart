import 'dart:math' as math;

import 'package:flutter/cupertino.dart';

class Responsive {
  final iphoneElevenPixelHeight = 812;
  final iphoneElevenPixelWidth = 375;

  double width, height, ip;

  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;

    width = size.width;
    height = size.height;
    ip = math.sqrt(math.pow(width, 2) + math.pow(height, 2));
  }

  double heightCustom(double value) {
    return height * value;
  }

  double widthCustom(double value) {
    return width * value;
  }

  double proportionalFont(double fontSize) {
    return (height * fontSize) / iphoneElevenPixelHeight;
  }

  double proportionalWidth(double value) {
    return (width * value) / iphoneElevenPixelWidth;
  }

  double propotionalHeight(double value) {
    return (height * value) / iphoneElevenPixelHeight;
  }
}
