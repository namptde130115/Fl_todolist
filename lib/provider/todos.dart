import 'package:flutter/widgets.dart';
import 'package:todo_list/model/todo.dart';

class TodosProvider extends ChangeNotifier {
  final List<Todo> _todos = [
    Todo('Buy milk', true),
    Todo('Buy eggs', true),
    Todo('Buy bread', false)
  ];

  int get todoCount => _todos.length;
  List<Todo> get todoList => _todos.map((todo) => todo).toList();
  List<String> get todoListText => _todos.map((todo) => todo.text).toList();
  void addTodo(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();
  }

  void editTodo(Todo todo, String text) {
    todo.text = text;
    notifyListeners();
  }
}
