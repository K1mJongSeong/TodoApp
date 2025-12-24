import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';

class ToDoViewModel extends ChangeNotifier {
  final List<ToDoEntity> _todos = [];
  
  List<ToDoEntity> get todos {
    // 즐겨찾기 항목을 먼저 표시하고, 완료된 항목은 아래로
    final favorites = _todos.where((t) => t.isFavorite && !t.isDone).toList();
    final normal = _todos.where((t) => !t.isFavorite && !t.isDone).toList();
    final done = _todos.where((t) => t.isDone).toList();
    
    // 마감일 기준으로 정렬
    favorites.sort((a, b) => _compareDueDate(a.dueDate, b.dueDate));
    normal.sort((a, b) => _compareDueDate(a.dueDate, b.dueDate));
    
    return [...favorites, ...normal, ...done];
  }

  int _compareDueDate(DateTime? a, DateTime? b) {
    if (a == null && b == null) return 0;
    if (a == null) return 1;
    if (b == null) return -1;
    return a.compareTo(b);
  }

  void addTodo(ToDoEntity todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void updateTodo(int index, ToDoEntity updatedTodo) {
    final originalIndex = _todos.indexOf(todos[index]);
    if (originalIndex != -1) {
      _todos[originalIndex] = updatedTodo;
      notifyListeners();
    }
  }

  void deleteTodo(int index) {
    final originalIndex = _todos.indexOf(todos[index]);
    if (originalIndex != -1) {
      _todos.removeAt(originalIndex);
      notifyListeners();
    }
  }

  void toggleDone(int index) {
    final todo = todos[index];
    final originalIndex = _todos.indexOf(todo);
    if (originalIndex != -1) {
      _todos[originalIndex] = todo.copyWith(isDone: !todo.isDone);
      notifyListeners();
    }
  }

  void toggleFavorite(int index) {
    final todo = todos[index];
    final originalIndex = _todos.indexOf(todo);
    if (originalIndex != -1) {
      _todos[originalIndex] = todo.copyWith(isFavorite: !todo.isFavorite);
      notifyListeners();
    }
  }

  void setDueDate(int index, DateTime? date) {
    final todo = todos[index];
    final originalIndex = _todos.indexOf(todo);
    if (originalIndex != -1) {
      _todos[originalIndex] = todo.copyWith(
        dueDate: date,
        clearDueDate: date == null,
      );
      notifyListeners();
    }
  }
}
