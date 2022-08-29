import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/page/home_page.dart';
import 'package:todo_list/provider/todos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => TodosProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ));
}
