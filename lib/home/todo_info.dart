import 'package:flutter/material.dart';
import 'package:my_todos/services/todo_provider.dart';
import 'package:my_todos/todoData/todo_model.dart';

class TodoInfo extends StatefulWidget {
  final TodoModel todo;
  const TodoInfo({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoInfo> createState() => _TodoInfoState();
}

class _TodoInfoState extends State<TodoInfo> {
  late bool isDone;
  late String description;
  late DateTime dateCreated;
  late DateTime deadline;
  @override
  void initState() {
    super.initState();
    isDone = widget.todo.isDone;
    description = widget.todo.todoDescription;
    dateCreated = widget.todo.dateCreated;
    deadline = widget.todo.todoDeadline;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          bottom: 30,
          right: 20,
        ),
        child: Column(
          children: [
            const Text(
              'Task info',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 1, 55),
                fontWeight: FontWeight.w700,
                fontSize: 21,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              constraints: BoxConstraints(maxHeight: 150),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Text(
                  description,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(221, 35, 35, 35),
                    fontSize: 17.5,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                const Text(
                  'created on:        ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 1, 55),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${dateCreated.day} | ${dateCreated.month} | ${dateCreated.year}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Color.fromARGB(221, 92, 91, 91),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'deadline set:     ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 1, 55),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '${deadline.day} | ${deadline.month} | ${deadline.year}',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(221, 92, 91, 91),
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Text(
                  'status:                 ',
                  style: TextStyle(
                    color: Color.fromARGB(255, 8, 1, 55),
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  isDone ? 'Finished' : 'Not Finished',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Color.fromARGB(221, 92, 91, 91),
                      fontSize: 15),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isFinished(widget.todo, context),
                  IconButton(
                    tooltip: 'Delete Forever',
                    color: Colors.red,
                    icon: const Icon(Icons.delete_forever_rounded),
                    onPressed: () async {
                      await TodoDatabase.instance.delete(widget.todo.id);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget isFinished(TodoModel todo, context) {
    if (isDone) {
      return IconButton(
        tooltip: 'Mark as Not Finished',
        color: Colors.amber,
        icon: const Icon(Icons.done),
        onPressed: () {
          setState(() {
            isDone = false;
          });
          update();
          Navigator.pop(context);
        },
      );
    } else {
      return IconButton(
        tooltip: 'Mark as Finished',
        color: Colors.amber,
        icon: const Icon(Icons.check_box_outline_blank),
        onPressed: () {
          setState(() {
            isDone = true;
          });
          update();
          Navigator.pop(context);
        },
      );
    }
  }

  void update() async {
    final TodoModel updated = widget.todo.copy(isDone: !widget.todo.isDone);
    await TodoDatabase.instance.update(updated);
  }
}
