import 'package:flutter/material.dart';
import '../viewmodels/todo_viewmodel.dart';
import 'package:provider/provider.dart';

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
      floatingActionButton: _AddTodoButton(
        onPressed: viewModel.addTodo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: viewModel.todos.length,
          itemBuilder: (_, index) {
            final todo = viewModel.todos[index];
            return _TodoCard(title: todo.title);
          },
        ),
      ),
    );
  }
}

class _TodoCard extends StatelessWidget {
  final String title;

  const _TodoCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/sample.webp',
            width: 100,
            height: 100,
          ),
          const SizedBox(height: 12),
          const Text(
            "텍스트 1",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}


class _AddTodoButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddTodoButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.blue,
      onPressed: onPressed,
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add,
        size: 24,
        color: Colors.white,
      ),
    );
  }
}
