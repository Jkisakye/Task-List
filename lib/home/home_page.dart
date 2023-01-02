import 'package:flutter/material.dart';
import 'package:my_todos/todoData/create_todo.dart';
import 'package:my_todos/widgets/loading.dart';
import 'package:my_todos/widgets/todo_list.dart';
import 'package:flutter_svg/svg.dart';

import '../services/todo_provider.dart';
import '../todoData/todo_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<TodoModel> todoList = [];
  bool isLoading = false;

  @override
  void initState() {
    refreshTodos();
    super.initState();
  }

  @override
  void dispose() {
    TodoDatabase.instance.closeDb();
    super.dispose();
  }

  Future refreshTodos() async {
    setState(() {
      isLoading = true;
    });
    todoList = await TodoDatabase.instance.readAllTodos();
    setState(() {
      isLoading = false;
    });
  }

  // Widget showImage() {
  //   const String svgImageName = 'images/undraw_no_data_re_kwbl.svg';
  //   final Widget svg = SvgPicture.asset(
  //     svgImageName,
  //     semanticsLabel: 'no data image',
  //   );
  //   return svg;
  // }

  @override
  Widget build(BuildContext context) {
    refreshTodos();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              const SliverAppBar(
                expandedHeight: 230,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('Task List'),
                ),
                floating: true,
                pinned: true,
              ),
            ]),
        body: todoList.isEmpty
            ? Center(
                child: SizedBox(
                    height: 200,
                    width: 200,
                    child:
                        SvgPicture.asset('images/undraw_no_data_re_kwbl.svg')),
              )
            : SafeArea(
                child: TodoList(
                  todos: todoList,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (BuildContext context) => const CreateTodo()),
          );
        },
        tooltip: 'New task',
        child: const Icon(Icons.alarm_add_sharp),
      ),
    );
  }
}
