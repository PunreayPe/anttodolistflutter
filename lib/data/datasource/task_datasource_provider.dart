import 'package:ant_todo_list/data/datasource/task_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskDatasourceProvider = Provider<TaskDataSource>((ref) {
  return TaskDataSource();
});
