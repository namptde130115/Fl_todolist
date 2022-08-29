import 'package:flutter/material.dart';
import 'package:todo_list/provider/todos.dart';
import 'package:todo_list/widget/add_todo.dart';
import 'package:todo_list/widget/todo_item.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Column(
          children: <Widget>[
            const AddTodo(),
            Expanded(
              child: ListView.builder(
                  itemCount: provider.todoList.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      todo: provider.todoList[index],
                    );
                  }),
            )
          ],
        ));
  }
}
