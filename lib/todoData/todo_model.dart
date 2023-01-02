class TodoModel {
  final int? id; //will be created by the database
  bool isDone;
  final String todoDescription;
  final DateTime dateCreated;
  final DateTime todoDeadline;

  TodoModel(
      {this.id,
      required this.isDone,
      required this.todoDescription,
      required this.dateCreated,
      required this.todoDeadline});

//method creating a JSON map from each object
  Map<String, Object?> toJSON() {
    Map<String, Object?> map = {
      TodoFields.id: id,
      TodoFields.isDone: isDone ? 1 : 0, //sql database understands 1 or 0
      TodoFields.todoDescription: todoDescription,
      TodoFields.dateCreated: dateCreated.toIso8601String(), //must be a string
      TodoFields.todoDeadline:
          todoDeadline.toIso8601String(), //must be a string
    };

    return map;
  }

//method creating todo  objects from each JSON map
  static TodoModel fromJSON(Map<String, Object?> JSON) {
    TodoModel todo = TodoModel(
      id: JSON[TodoFields.id] as int,
      isDone: JSON[TodoFields.isDone] ==
          1, //checks whether it's 1 or 0 and if 1 it returns true else false
      todoDescription: JSON[TodoFields.todoDescription] as String,
      dateCreated: DateTime.parse(JSON[TodoFields.dateCreated] as String),
      todoDeadline: DateTime.parse(JSON[TodoFields.todoDeadline] as String),
    );

    return todo;
  }

//make a copy of an object
// the ({ args? }) argument syntax is used to create a method with only optional arguments
  TodoModel copy(
      {int? id,
      bool? isDone,
      String? todoDescription,
      DateTime? dateCreated,
      DateTime? todoDeadline}) {
    return TodoModel(
      id: id ?? this.id,
      isDone: isDone ?? this.isDone,
      todoDescription: todoDescription ?? this.todoDescription,
      dateCreated: dateCreated ?? this.dateCreated,
      todoDeadline: todoDeadline ?? this.todoDeadline,
    );
  }
}

//db table
const String tableTodos = 'todos';

class TodoFields {
  //list of all fields in the table
  static final List<String> values = [
    id,
    isDone,
    todoDescription,
    dateCreated,
    todoDeadline
  ];

  static const String id = '_id';
  static const String isDone = 'isDone';
  static const String todoDescription = 'todoDescription';
  static const String dateCreated = 'dateCreated';
  static const String todoDeadline = 'todoDeadline';
}
