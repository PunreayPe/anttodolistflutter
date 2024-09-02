import 'package:ant_todo_list/data/models/task.dart';

abstract class TaskRepository {
  Future<void> createTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
  Future<List<Task>> getAllTasks();
}
