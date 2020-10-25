import 'package:intl/intl.dart';

import 'index.dart';

class DateUtils {
  static DateTime toDateTime(dynamic val) {
    if (val is String) {
      return DateTime.parse(val);
    }
    if (val is DateTime) {
      return val;
    }
    return DateTime.now();
  }

  static Duration diff(dynamic date1, dynamic date2) {
    try {
      if (isNull(date1) || isNull(date2)) {
        return Duration(seconds: 0);
      }
      date1 = DateUtils.toDateTime(date1);
      date2 = DateUtils.toDateTime(date2);
      return date1.difference(date2);
    } catch (e) {
      return Duration(seconds: 0);
    }
  }

  static formatDate(dynamic date, {format = 'MM-dd HH:mm:ss'}) {
    date = DateUtils.toDateTime(date);
    return new DateFormat(format).format(date);
  }

  static String specFormatDate(dynamic date) {
    try {
      if (isNull(date)) {
        return '';
      }

      date = DateUtils.toDateTime(date);

      DateTime now = DateTime.now();
      Duration diff = date.difference(now);

      if (diff.inDays == 0) {
        DateFormat dateFormat = new DateFormat('HH:mm:ss');
        if (now.day == date.day) {
          return '今天 ${dateFormat.format(date)}';
        } else {
          return '昨天 ${dateFormat.format(date)}';
        }
      }

      if (diff.inDays == 1) {
        DateFormat dateFormat = new DateFormat('HH:mm:ss');
        return '昨天 ${dateFormat.format(date)}';
      }

      if (now.year == date.year) {
        return new DateFormat('MM-dd HH:mm').format(date);
      }

      return new DateFormat('yyyy-MM-dd HH:mm').format(date);
    } catch (e) {
      return date;
    }
  }
}
