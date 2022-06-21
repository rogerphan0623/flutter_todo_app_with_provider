import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/todos.dart';
import 'todo_widget.dart';

class TodoListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;

    return todos.isEmpty
        ? Center(
          child: Text(
              'No todos',
              style: TextStyle(fontSize: 20),
            ),
        )
        : ListView.separated(
            separatorBuilder: (context, index) => Container(
              height: 20,
            ),
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final todo = todos[index];

              return TodoWidget(
                todo: todo,
              );
            },
          );
  }
}
