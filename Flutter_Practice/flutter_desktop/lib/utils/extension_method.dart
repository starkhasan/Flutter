import 'package:flutter_desktop/constants/strings.dart';

extension StringUtils on String {

  
}

extension DoubleUtil on double {
  String get convertToCelcius {
    var temp = this - 273.0;
    return temp.toStringAsFixed(0)+Strings.degree;
  }
}