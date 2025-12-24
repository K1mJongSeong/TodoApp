import 'package:flutter/material.dart';
import '../viewmodels/todo_viewmodel.dart';
import '../viewmodels/theme_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/add_todo_button.dart';
import '../widgets/todo_view.dart';
import 'add_todo_bottom_sheet.dart';
import 'no_todo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // AppBar title 상수
  static const String appBarTitle = "종성's Tasks";

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ToDoViewModel>();
    final themeViewModel = context.watch<ThemeViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          appBarTitle,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          // 다크 모드 토글 버튼
          IconButton(
            icon: Icon(
              themeViewModel.isDarkMode 
                  ? Icons.light_mode_outlined 
                  : Icons.dark_mode_outlined,
              color: Colors.white,
            ),
            tooltip: themeViewModel.isDarkMode ? '라이트 모드' : '다크 모드',
            onPressed: () {
              themeViewModel.toggleTheme();
            },
          ),
        ],
      ),
      floatingActionButton: AddTodoButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF303134)
                : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => const AddTodoBottomSheet(),
          );

          if (result != null) {
            context.read<ToDoViewModel>().addTodo(result);
          }
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: viewModel.todos.isEmpty
            ? const NoToDo(appBarTitle: appBarTitle)
            : ListView.builder(
                itemCount: viewModel.todos.length,
                itemBuilder: (context, index) {
                  final todo = viewModel.todos[index];
                  return ToDoView(
                    toDo: todo,
                    onToggleDone: () =>
                        context.read<ToDoViewModel>().toggleDone(index),
                    onToggleFavorite: () =>
                        context.read<ToDoViewModel>().toggleFavorite(index),
                    onDelete: () =>
                        context.read<ToDoViewModel>().deleteTodo(index),
                  );
                },
              ),
      ),
    );
  }
}
