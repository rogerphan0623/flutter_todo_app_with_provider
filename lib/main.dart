import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/todos.dart';
import 'widgets/add_todo_dialog_widget.dart';
import 'widgets/completed_list_widget.dart';
import 'widgets/todo_list_widget.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context)=> TodosProvider(),
      child: MaterialApp
        (
          debugShowCheckedModeBanner: false,
          home : MyApp())));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    final tabs = [
      TodoListWidget(),
      CompletedListWidget(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Todo App"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fact_check_outlined),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.done,
              size: 28,
            ),
            label: 'Completed',
          ),
        ],
      ),
      body: tabs[selectedIndex],
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.blue,
        onPressed: () => showDialog(
          builder: (context) => AddTodoDialogWidget(), context: context,
          barrierDismissible: true,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
