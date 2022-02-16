import 'package:intl/intl.dart';

String dateTimeFormatToString(DateTime date) {
  return DateFormat('dd-MM-yyyy – hh:mm').format(date);
}

DateTime dateTimeFormatToDateTime(String date) {
  var newDate = date.replaceAll(' – ', ' ');
  var formatted = newDate.split('-');
  var year = formatted.elementAt(2);
  var day = formatted.elementAt(0);
  formatted[2] = day;
  formatted[0] = year + ' ';
  var newFormatted = formatted.join();
  var formattednew = newFormatted.split(' ');
  var formattednew2 = formattednew.elementAt(2).split('');
  var month = formattednew2.elementAt(0) + formattednew2.elementAt(1);
  var formattedDay = formattednew2.elementAt(2) + formattednew2.elementAt(3);
  var finalString = formattednew.elementAt(0) +
      '-' +
      month +
      '-' +
      formattedDay +
      ' ' +
      formattednew.elementAt(1);

  return DateTime.parse(finalString);
}
