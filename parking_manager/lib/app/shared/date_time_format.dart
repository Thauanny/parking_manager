import 'package:intl/intl.dart';

String dateTimeFormat(DateTime date) {
  return DateFormat('dd-MM-yyyy – hh:mm').format(date);
}
