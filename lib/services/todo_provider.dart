import 'package:my_todos/todoData/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//FOLLOWING THE ' CRUD '; Create Read Update Delete

class TodoDatabase {
  //calling the private constructor in the instance
  static final TodoDatabase instance = TodoDatabase._init();
  static Database? _database;
  //private constructor
  TodoDatabase._init();

  Future<Database> get database async {
    if (_database != null) {
      //print("database already exists");
      return _database!;
    }

    _database = await _initDB('todos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    //print(path);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

//create a table in the database
  Future _createDB(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $tableTodos (
    ${TodoFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${TodoFields.isDone} BOOLEAN NOT NULL,
    ${TodoFields.todoDescription} TEXT NOT NULL,
    ${TodoFields.dateCreated} TEXT NOT NULL,
    ${TodoFields.todoDeadline} TEXT NOT NULL
  )
  ''');
  }

//inserting a todo object into the table
  Future<TodoModel> create(TodoModel todo) async {
    final db = await instance.database;
//could also use raw sql using rawInsert() but this is easier
    final id = await db.insert(tableTodos, todo.toJSON());
    return todo.copy(id: id);
  }

//read one Todo object
  Future<TodoModel> readTodo(int id) async {
    final db = await instance.database;

    final maps = await db.query(tableTodos,
        columns: TodoFields.values,
        where:
            '${TodoFields.id} = ?', //using where and whereArgs is safe since 'where field = var' doesnt prevent sql injections
        whereArgs: [id]);

    if (maps.isNotEmpty) {
      return TodoModel.fromJSON(maps.first);
    } else {
      throw Exception(' ID: $id not found');
    }
  }

//read all todos
  Future<List<TodoModel>> readAllTodos() async {
    final db = await instance.database;

    const oderBy = '${TodoFields.todoDeadline} ASC';
    final result = await db.query(tableTodos,
        orderBy: oderBy); //this returns a list of JSON maps or objects

    return result
        .map((json) => TodoModel.fromJSON(json))
        .toList(); //mapping the list of JSON objects to a list of TodoModel objects
  }

//update ie mark as done
  Future<int> update(TodoModel todo) async {
    final db = await instance.database;
    return db.update(tableTodos, todo.toJSON(),
        where: '${TodoFields.id} = ?', whereArgs: [todo.id]);
  }

//delete an object
  Future<int> delete(int? id) async {
    final db = await instance.database;

    return await db
        .delete(tableTodos, where: '${TodoFields.id} = ?', whereArgs: [id]);
  }

//close
  Future closeDb() async {
    final db = await instance.database;
    db.close();
  }
}
