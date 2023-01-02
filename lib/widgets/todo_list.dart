import 'package:flutter/material.dart';
import 'package:my_todos/home/todo_info.dart';
import 'package:my_todos/todoData/todo_model.dart';
import 'package:my_todos/widgets/todo_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TodoList extends StatefulWidget {
  final List<TodoModel> todos;
  const TodoList({Key? key, required this.todos}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    // final todos = Provider.of<List<TodoModel>>(context);

    //bottom sheet
    void _showTodoInfo(TodoModel todoObject) {
      showModalBottomSheet(
          backgroundColor: Color.fromARGB(255, 239, 238, 243),
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          builder: (context) {
            return TodoInfo(todo: todoObject);
          });
    }

    return StaggeredGridView.countBuilder(
      // physics: const BouncingScrollPhysics(
      //   parent: AlwaysScrollableScrollPhysics(),
      // ),
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemCount: widget.todos.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            _showTodoInfo(widget.todos[index]);
          },
          child: todoCard(widget.todos[index], index),
        );
      },
    );
  }
}

//     return ListView.builder(
//         physics: const BouncingScrollPhysics(
//           parent: AlwaysScrollableScrollPhysics(),
//         ),
//         itemCount: widget.todos.length,
//         itemBuilder: (BuildContext context, int index) {
//           return InkWell(
//             onTap: () {
//               _showTodoInfo(widget.todos[index]);
//             },
//             child: todoCard(widget.todos[index], index),
//           );
//         });
//   }
// }
