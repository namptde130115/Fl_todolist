import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';
import 'package:todo_list/provider/todos.dart';
import 'package:provider/provider.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({
    Key? key,
  }) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodo();
}

class _AddTodo extends State<AddTodo> {
  String inputValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context, listen: false);
    return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter todo here',
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  if (provider.todoListText.contains(value)) {
                    return 'Todo already exists';
                  }
                  return null;
                },
                onChanged: (String value) {
                  inputValue = value;
                },
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    provider.addTodo(Todo(inputValue, false));
                    _formKey.currentState!.reset();
                  }
                },
              ),
            ],
          ),
        ));
  }
}
