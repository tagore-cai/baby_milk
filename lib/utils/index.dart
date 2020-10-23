import 'package:intl/intl.dart';

String formatDate(dynamic dateString) {
  try {
    if (dateString == '' || dateString == null || dateString == 'null') {
      return '';
    }
    DateTime date;
    if (dateString is String) {
      date = DateTime.parse(dateString);
    }
    if (dateString is DateTime) {
      date = dateString;
    }
    DateTime now = DateTime.now();
    Duration diff = date.difference(now);
    if (diff.inDays == 0) {
      DateFormat dateFormat = new DateFormat('HH:mm:ss');
      return '今天 ${dateFormat.format(date)}';
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
    return dateString;
  }
}
