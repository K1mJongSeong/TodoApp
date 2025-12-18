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

  void toggleDone(int index) {
    final todo = _todos[index];
    _todos[index] = ToDoEntity(
      title: todo.title,
      description: todo.description,
      isFavorite: todo.isFavorite,
      isDone: !todo.isDone,
    );
    notifyListeners();
  }

  void toggleFavorite(int index) {
    final todo = _todos[index];
    _todos[index] = ToDoEntity(
      title: todo.title,
      description: todo.description,
      isFavorite: !todo.isFavorite,
      isDone: todo.isDone,
    );
    notifyListeners();
  }

}