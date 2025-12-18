import 'package:flutter/material.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'package:provider/provider.dart';

import '../widgets/add_todo_button.dart';
import '../widgets/todo_card.dart';
import 'add_todo_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ToDoViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          "김종성's Tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: AddTodoButton(
        onPressed: () async {
          final result = await showModalBottomSheet(
            context: context, builder: (_) => const AddTodoBottomSheet(),
          );

          if(result != null) {
            context.read<ToDoViewModel>().addTodo(result);
          }
        },//viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: viewModel.todos.length,
          itemBuilder: (_, index) {
            final todo = viewModel.todos[index];
            return TodoCard(title: todo.title);
          },
        ),
      ),
    );
  }
}