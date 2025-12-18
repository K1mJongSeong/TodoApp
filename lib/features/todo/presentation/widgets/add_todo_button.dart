import 'package:flutter/material.dart';

class AddTodoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AddTodoButton({
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blue,
      child: child,
    );
  }
}