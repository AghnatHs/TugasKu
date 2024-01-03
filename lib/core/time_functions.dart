import 'package:intl/intl.dart';

String dueDateToFormattedStr({required String dueDate}) {
  return DateFormat('EEEE, d MMM y,').add_Hm().format(DateTime.parse(dueDate));
}
