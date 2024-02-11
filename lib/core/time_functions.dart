import 'package:intl/intl.dart';

String dueDateToFormattedStr({required String dueDate}) {
  try {
    return DateFormat('EEEE, d MMM y,').add_Hm().format(DateTime.parse(dueDate));
  } catch (e) {
    return 'No due date';
  }
}
