import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/task_provider.dart';
import 'screens/todo_list.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskProvider(),
      child: MaterialApp(
        title: 'To-Do List',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color(0xFF006400), // Dark Green
          scaffoldBackgroundColor: const Color(0xFFF5F5DC), // Beige
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF006400), // Dark Green
            foregroundColor: Colors.white,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF006400), // Dark Green
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            labelStyle: const TextStyle(color: Colors.black87),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black26),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        home: const TodoListPage(),
      ),
    );
  }
}
