import 'package:ant_todo_list/utils/utils.dart';
import 'package:flutter/material.dart';

@immutable
class DBKeys {
  const DBKeys._();
  static const String dbName = 'task5.db';
  static const String dbTable = 'task';
  static const String idColumn = TaskKeys.id;
  static const String titleColumn = TaskKeys.title;
  static const String noteColumn = TaskKeys.note;
  static const String timeColumn = TaskKeys.time;
  static const String dateColumn = TaskKeys.date;
  static const String categoryColumn = TaskKeys.category;
  static const String isCompletedColumn = TaskKeys.isCompleted;
}
