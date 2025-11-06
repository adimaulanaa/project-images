import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<void> initDateFormat() async {
  await initializeDateFormatting('id_ID');
}

extension DateFormatExt on DateTime {
  String format(String pattern) => DateFormat(pattern, 'id_ID').format(this);
}
