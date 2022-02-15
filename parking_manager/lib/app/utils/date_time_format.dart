import 'package:intl/intl.dart';

String dateTimeFormatToString(DateTime date) {
  return DateFormat('dd-MM-yyyy – hh:mm').format(date);
}

DateTime dateTimeFormatToDateTime(String date) {
  return DateTime.parse(date);
}
