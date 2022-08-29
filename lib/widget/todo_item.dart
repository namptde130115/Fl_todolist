import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/provider/todos.dart';

class TodoItem extends StatefulWidget {
  final Todo todo;

  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(children: [
            Checkbox(
              value: widget.todo.isDone,
              onChanged: (value) {
                provider.toggleTodoStatus(widget.todo);
              },
            ),
            Text(widget.todo.text),
          ]),
          Row(children: [
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                provider.removeTodo(widget.todo);
              },
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.green,
              onPressed: () async {
                final todoText = await openDialog(widget.todo.text);
                if (todoText == null || todoText.isEmpty) return;
                provider.editTodo(widget.todo, todoText);
              },
            ),
          ])
        ]);
  }

  String _editValue = '';

  Future openDialog(String text) => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
              title: const Text('Your todo'),
              content: TextField(
                autofocus: true,
                controller: TextEditingController(text: text),
                onChanged: (value) {
                  _editValue = value;
                },
              ),
              actions: [
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    Navigator.of(context).pop(_editValue);
                  },
                ),
              ]));
}
