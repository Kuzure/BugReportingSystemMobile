import 'package:intl/intl.dart';

class DateFormatHelper {
  static DateFormat _ddMMYYYY = DateFormat('dd.MM.yyyy');

  static DateFormat _hhmm = DateFormat('HH:mm');


  static DateFormat ddMMYYYY() => _ddMMYYYY;

  static DateFormat hhmm() => _hhmm;

}