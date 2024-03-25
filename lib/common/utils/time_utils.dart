import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:timeago/timeago.dart' as timeago;

class TimeUtils {
  static final timeFormat = DateFormat('HH:mm', 'en_US');
  static final yearDateFormat = DateFormat('yy/MM/dd', 'ko');
  static final monthDateFormat = DateFormat('MM/dd', 'ko');

  static String timeAgoFormatter(BuildContext context, DateTime time) =>
      timeago.format(time, locale: context.locale.languageCode);

  static String formattedYyMmFormatter(DateTime time) =>
      yearDateFormat.format(time);

  static String formattedMmDdFormatter(DateTime time) =>
      monthDateFormat.format(time);

  static String formattedHhMmFormatter(DateTime time) =>
      timeFormat.format(time);

  static String timeFormatter(BuildContext context, String dateTime) {
    DateTime time = DateTime.parse(dateTime);
    int dateDiff = DateTime.now().day - time.day;
    int yearDiff = DateTime.now().year - time.year;

    if (dateDiff >= 7) {
      if (yearDiff >= 1) {
        return formattedYyMmFormatter(time);
      }

      return formattedMmDdFormatter(time);
    }

    return timeAgoFormatter(context, time);
  }

  static String timeFormatterForComment(BuildContext context, String dateTime) {
    DateTime time = DateTime.parse(dateTime);
    return "${formattedYyMmFormatter(time)} ${formattedHhMmFormatter(time)}";
  }
}
