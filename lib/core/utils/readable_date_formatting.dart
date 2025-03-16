import 'package:intl/intl.dart';

String readableDateFormatting(String dateString) {
  DateTime parsedDate = DateTime.parse(dateString);

  return DateFormat("MMMM d, y").format(parsedDate);
}
