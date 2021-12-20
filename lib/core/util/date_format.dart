import 'package:intl/intl.dart';

String dateFormat(DateTime dateTime){
  var formatter = DateFormat('yyyy-MMM-dd');
  String formatted = formatter.format(dateTime);
  return formatted;
}

String dateFormatHour(DateTime dateTime){
  var formatter = DateFormat('Hm');
  String formatted = formatter.format(dateTime);
  return formatted;
}