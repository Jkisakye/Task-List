import 'package:flutter/material.dart';
import 'package:my_todos/services/todo_provider.dart';
import 'package:my_todos/todoData/date.dart';
import 'package:my_todos/todoData/todo_model.dart';

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  bool isDone = false;
  String description = '';
  DateTime dateCreated = DateTime.now();
  DateTime deadline = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> getDate() async {
      final currentDate = DateTime.now();
      final selectedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: currentDate,
        lastDate: DateTime(currentDate.year + 10),
      );
      if (selectedDate != null) {
        setState(() {
          deadline = selectedDate;
        });
      }
    }

    Widget pickDate() {
      return Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 20,
          left: 20,
        ),
        child: Row(
          children: [
            const Text(
              'Deadline:',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 1, 55),
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            InkWell(
              onTap: () => getDate(),
              child: dateWigdet(deadline),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a Task'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              await saveTodo();
              Navigator.pop(context);
            }
          },
          tooltip: 'Save task',
          child: const Icon(Icons.check_sharp),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 40, right: 40, top: 50, bottom: 20),
                child: SizedBox(
                  height: 240,
                  child: Card(
                    elevation: 100,
                    child: buildForm(),
                  ),
                ),
              ),
              pickDate()
            ],
          ),
        ));
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) => value!.isEmpty ? '*required' : null,
              onChanged: (val) {
                setState(() => description = val);
              },
              maxLines: 8,
              style: const TextStyle(
                  color: Color.fromARGB(221, 35, 35, 35),
                  fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                hintText: 'Type something...',
                hintStyle:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void savePressed() async {

  // }

  Future saveTodo() async {
    final TodoModel todo = TodoModel(
        isDone: isDone,
        todoDescription: description,
        dateCreated: dateCreated,
        todoDeadline: deadline);

    await TodoDatabase.instance.create(todo);
  }
}
