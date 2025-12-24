import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/todo_entity.dart';
import '../viewmodels/todo_viewmodel.dart';

class ToDoDetailPage extends StatelessWidget {
  final int todoIndex;

  const ToDoDetailPage({
    super.key,
    required this.todoIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final viewModel = context.watch<ToDoViewModel>();
    
    // 인덱스가 유효한지 확인
    if (todoIndex >= viewModel.todos.length) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const Center(child: Text('할 일을 찾을 수 없습니다.')),
      );
    }

    final todo = viewModel.todos[todoIndex];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF202124) : const Color(0xFFE8E8E8),
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF303134) : const Color(0xFFE8E8E8),
        foregroundColor: isDark ? Colors.white : Colors.black87,
        elevation: 0,
        // 1. leading: 뒤로가기 버튼
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // 1. actions: 즐겨찾기 버튼
        actions: [
          IconButton(
            icon: Icon(
              todo.isFavorite ? Icons.star : Icons.star_border,
              color: todo.isFavorite ? Colors.amber : (isDark ? Colors.white : Colors.black87),
            ),
            onPressed: () {
              // favorite 변경 (ViewModel을 통해 양쪽 페이지에 반영)
              context.read<ToDoViewModel>().toggleFavorite(todoIndex);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Text(
                todo.title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              // 세부 내용
              if (todo.description != null && todo.description!.isNotEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.short_text,
                      size: 20,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        todo.description!,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark ? Colors.white70 : Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // 세부 내용 입력 안내 (description이 없을 때)
              if (todo.description == null || todo.description!.isEmpty) ...[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.short_text,
                      size: 20,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '세부 내용은 여기에 작성합니다.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
