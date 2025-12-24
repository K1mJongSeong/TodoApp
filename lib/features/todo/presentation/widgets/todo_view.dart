import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/todo_entity.dart';

class ToDoView extends StatelessWidget {
  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;
  final VoidCallback? onDelete;

  const ToDoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
    this.onDelete,
  });

  String _formatDueDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return '오늘';
    } else if (dateOnly == tomorrow) {
      return '내일';
    } else {
      return DateFormat('M월 d일').format(date);
    }
  }

  bool _isOverdue() {
    if (toDo.dueDate == null || toDo.isDone) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueOnly = DateTime(toDo.dueDate!.year, toDo.dueDate!.month, toDo.dueDate!.day);
    return dueOnly.isBefore(today);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF303134) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.white60 : Colors.black54;

    return Dismissible(
      key: Key(toDo.title + toDo.hashCode.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.only(right: 20),
        alignment: Alignment.centerRight,
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 24),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onToggleDone,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
              child: Row(
                children: [
                  // 체크박스
                  IconButton(
                    icon: Icon(
                      toDo.isDone
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: toDo.isDone 
                          ? const Color(0xFF34A853) 
                          : (isDark ? Colors.white54 : Colors.grey),
                      size: 26,
                    ),
                    onPressed: onToggleDone,
                  ),

                  // 제목 및 마감일
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          toDo.title,
                          style: TextStyle(
                            fontSize: 16,
                            decoration: toDo.isDone 
                                ? TextDecoration.lineThrough 
                                : null,
                            color: toDo.isDone 
                                ? subtitleColor 
                                : textColor,
                          ),
                        ),
                        if (toDo.dueDate != null) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                size: 14,
                                color: _isOverdue() 
                                    ? Colors.red 
                                    : subtitleColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                _formatDueDate(toDo.dueDate!),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _isOverdue() 
                                      ? Colors.red 
                                      : subtitleColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),

                  // 즐겨찾기 아이콘
                  IconButton(
                    icon: Icon(
                      toDo.isFavorite ? Icons.star : Icons.star_border,
                      color: toDo.isFavorite 
                          ? Colors.amber 
                          : (isDark ? Colors.white54 : Colors.grey),
                      size: 24,
                    ),
                    onPressed: onToggleFavorite,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
