import "package:realm/realm.dart";

part 'task_model.g.dart';

@RealmModel()
class _Task {
  @PrimaryKey()
  late String id;
  late String description;
  late String due;
  late bool done;
}
