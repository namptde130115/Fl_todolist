import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Todo List',
      home: TodoList(),
    );
  }
}

class TodoItem {
  String text;
  bool isDone;
  TodoItem(this.text, this.isDone);
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final _todoItems = <TodoItem>[
    TodoItem('Buy milk', true),
    TodoItem('Buy eggs', false),
    TodoItem('Buy bread', false)
  ];

  String inputValue = '';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Enter todo here',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      if (_todoItems.contains(value)) {
                        return 'Todo already exists';
                      }
                      return null;
                    },
                    controller: TextEditingController(),
                    onChanged: (String value) {
                      inputValue = value;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      if (_formKey.currentState!.validate()) {
                        // Process data.
                        setState(() {
                          _todoItems.add(TodoItem(inputValue, false));
                          TextEditingController().clear();
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _todoItems.length,
                      itemBuilder: (context, index) {
                        return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Checkbox(
                                value: _todoItems[index].isDone,
                                onChanged: (value) {
                                  setState(() {
                                    _todoItems[index].isDone = value!;
                                  });
                                },
                              ),
                              Text(_todoItems[index].text),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    _todoItems.removeAt(index);
                                  });
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () async {
                                  final todoText =
                                      await openDialog(_todoItems[index].text);
                                  if (todoText == null || todoText.isEmpty)
                                    return;
                                  setState(() {
                                    _todoItems[index].text = todoText;
                                  });
                                },
                              ),
                            ]);
                      },
                    ),
                  ),
                ],
              ),
            )));
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
