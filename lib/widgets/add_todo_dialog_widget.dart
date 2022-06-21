import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import 'todo_form_widget.dart';

class AddTodoDialogWidget extends StatefulWidget {
  @override
  _AddTodoDialogWidgetState createState() => _AddTodoDialogWidgetState();
}

class _AddTodoDialogWidgetState extends State<AddTodoDialogWidget> {
 final _formKey= GlobalKey<FormState>();
  String title = '';
  String description = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'add Todo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TodoFormWidget(
              onChangedTitle: (title) {
                setState(() {
                  this.title = title;
                });
              },
              onChangedDescription: (description) {
                setState(() {
                  this.description = description;
                });
              },
              onSavedTodo: addTodo,
            )
          ],
        ),
      ),
    );
  }

  void addTodo() {
final isValid = _formKey.currentState!.validate();

if(!isValid) {
  return;
  } else{
    final todo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );
 final provider = Provider.of<TodosProvider>(context,listen: false);
 provider.addTodo(todo);

 Navigator.of(context).pop();
}
  }
}
