import 'package:ant_todo_list/data/models/task.dart';
import 'package:ant_todo_list/utils/db_keys.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TaskDataSource {
  static final TaskDataSource _instance = TaskDataSource._();
  factory TaskDataSource() => _instance;

  TaskDataSource._() {
    _initDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DBKeys.dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${DBKeys.dbTable}(
        ${DBKeys.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${DBKeys.titleColumn} TEXT,
        ${DBKeys.noteColumn} TEXT,
        ${DBKeys.dateColumn} TEXT,
        ${DBKeys.timeColumn} TEXT,
        ${DBKeys.categoryColumn} TEXT,
        ${DBKeys.isCompletedColumn} INTEGER
      )
      ''');
  }

  // Add
  Future<int> addTask(Task task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.insert(
          DBKeys.dbTable,
          task.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      },
    );
  }

  // Update
  Future<int> updateTask(Task task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn.update(DBKeys.dbTable, task.toJson(),
            where: 'id = ?', whereArgs: [task.id]);
      },
    );
  }

  // Delete
  Future<int> deleteTask(Task task) async {
    final db = await database;
    return db.transaction(
      (txn) async {
        return await txn
            .delete(DBKeys.dbTable, where: 'id = ?', whereArgs: [task.id]);
      },
    );
  }

  // View
  Future<List<Task>> getAllTask() async {
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(
      DBKeys.dbTable,
      orderBy: "id DESC",
    );
    return List.generate(
      data.length,
      (index) => Task.fromJson(data[index]),
    );
  }
}
