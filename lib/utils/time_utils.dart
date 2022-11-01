import 'package:intl/intl.dart';

class TimeUtils{

  static String formatTime(int milli) {
    final formatter = DateFormat("d MMM");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }

  static String formatTime2(int milli) {
    final formatter = DateFormat("d MMM, yyyy");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }

  static String formatTime3(int milli) {
    final formatter = DateFormat("yyyy-MM-dd");
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milli);
    return formatter.format(date);
  }



}