import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';


class ToDoViewModel extends ChangeNotifier {
  final List<ToDoEntity> _todos = [];
  List<ToDoEntity> get todos => _todos;

  void addTodo(result) {
    _todos.add(
      ToDoEntity(
        title: "New Todo",
        description: "Generated Todo",
      )
    );
    notifyListeners();
  }
}