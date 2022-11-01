import 'package:flutter/foundation.dart';

class PrintUtils{

  static void printOut(value) {
    if (kDebugMode) {
      print("$value");
    }
  }

}
