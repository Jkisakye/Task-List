import 'package:flutter/material.dart';
import 'package:my_todos/todoData/todo_model.dart';

Widget todoCard(TodoModel todo, int index) {
  final minHeight = getMinHeight(index);
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    child: Container(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  todo.todoDescription,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Color.fromARGB(221, 35, 35, 35),
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                //height: 20,
                height: indicatorDistance(minHeight),
              ),
              SizedBox(
                height: 2.4,
                width: 15,
                child: LinearProgressIndicator(
                  value: 1,
                  color: todo.isDone ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

/// To return different height for different widgets
double getMinHeight(int index) {
  switch (index % 4) {
    case 0:
      return 100;
    case 1:
      return 150;
    case 2:
      return 150;
    case 3:
      return 100;
    default:
      return 100;
  }
}

double indicatorDistance(double boxHeight) {
  if (boxHeight == 100) {
    return 20.0;
  } else {
    return 60.0;
  }
}
