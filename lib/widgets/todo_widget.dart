import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../page/edit_todo_page.dart';
import '../model/todo.dart';
import '../provider/todos.dart';
import '../util/utils.dart';

class TodoWidget extends StatelessWidget {
  final Todo todo;

  const TodoWidget({Key? key, required this.todo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: buildTodo(context),
    );
  }

  Widget buildTodo(BuildContext context)=> GestureDetector(
    onTap: ()=> editTodo(context, todo),
    
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Checkbox(
            activeColor: Colors.blue,
            checkColor: Colors.white,
            value: todo.isDone,
            onChanged: (_){
              final provider = Provider.of<TodosProvider>(context, listen: false);
              final isDone= provider.toggleTodoStatus(todo);
              Utils.showSnackBar(context,
                isDone ? 'Task completed' :
                    'Task marked incomplete'

              );

            },
          ),
          SizedBox(width: 20,),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      fontSize: 22,
                    ),
                  ),
                  if(todo.description.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Text(
                        todo.description,
                        style: TextStyle(fontSize: 20, height: 1.5),
                      ),
                    ),
                ],
              )
          ),
          IconButton(onPressed: (){
            editTodo(context,todo);
          }, icon: Icon(Icons.edit),color: Colors.green,),
          IconButton(onPressed: (){
            showAlertDialog(context);
          }, icon: Icon(Icons.delete),color: Colors.red,)
        ],
      ),
    ),
  );

  void deleteTodo(BuildContext context, Todo todo) {
 final provider = Provider.of<TodosProvider>(context, listen: false);
  provider.removeTodo(todo);

   Utils.showSnackBar(context, 'Deleted the task');
  }

  void editTodo(BuildContext context, Todo todo) {
   Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditTodoPage(todo: todo))) ;
  }
  showAlertDialog(BuildContext context) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        deleteTodo(context, todo);
        Navigator.of(context).pop();
      },
    );
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Todo"),
      content: Text("Are you sure."),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
void doNothing(BuildContext context) {}