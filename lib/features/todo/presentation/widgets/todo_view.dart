import 'package:flutter/material.dart';
import '../../domain/entities/todo_entity.dart';

class ToDoView extends StatelessWidget {
  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;

  const ToDoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              toDo.isDone
                  ? Icons.check_circle
                  : Icons.circle_outlined,
              color: toDo.isDone ? Colors.green : Colors.grey,
            ),
            onPressed: onToggleDone,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              toDo.title,
              style: TextStyle(
                fontSize: 16,
                decoration:
                toDo.isDone ? TextDecoration.lineThrough : null,
                color: toDo.isDone ? Colors.grey : Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 12),

          IconButton(
            icon: Icon(
              toDo.isFavorite ? Icons.star : Icons.star_border,
              color: toDo.isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: onToggleFavorite,
          ),
        ],
      ),
    );
  }
}
