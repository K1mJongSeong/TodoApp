import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/todo_entity.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({super.key});

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _titleFocusNode = FocusNode();

  bool _isFavorite = false;
  bool _showDescription = false;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void saveToDo() {
    if (_titleController.text.trim().isEmpty) return;

    final todo = ToDoEntity(
      title: _titleController.text.trim(),
      description: _showDescription ? _descriptionController.text.trim() : null,
      isFavorite: _isFavorite,
      dueDate: _dueDate,
    );

    Navigator.of(context).pop(todo);
  }

  Future<void> _selectDueDate() async {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: isDark
                ? const ColorScheme.dark(
                    primary: Color(0xFFFF9800),
                    onPrimary: Colors.white,
                    surface: Color(0xFF303134),
                    onSurface: Colors.white,
                  )
                : const ColorScheme.light(
                    primary: Color(0xFFFF5722),
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black87,
                  ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor = isDark ? Colors.white54 : Colors.black45;
    final iconColor = isDark ? Colors.white70 : Colors.black54;

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            focusNode: _titleFocusNode,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => saveToDo(),
            style: TextStyle(fontSize: 16, color: textColor),
            decoration: InputDecoration(
              hintText: '새 할 일',
              hintStyle: TextStyle(color: hintColor),
              border: InputBorder.none,
            ),
            onChanged: (_) => setState(() {}),
          ),

          if (_showDescription) ...[
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              minLines: 1,
              style: TextStyle(fontSize: 14, color: textColor),
              decoration: InputDecoration(
                hintText: '세부정보 추가',
                hintStyle: TextStyle(color: hintColor),
                border: InputBorder.none,
              ),
            ),
          ],

          // 마감일 표시 칩
          if (_dueDate != null) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: _selectDueDate,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isDark 
                      ? const Color(0xFF4A4A4A) 
                      : const Color(0xFFE8E8E8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: _isOverdue() ? Colors.red : iconColor,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDueDate(_dueDate!),
                      style: TextStyle(
                        fontSize: 13,
                        color: _isOverdue() ? Colors.red : textColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _dueDate = null;
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: iconColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          const SizedBox(height: 12),

          Row(
            children: [
              if (!_showDescription)
                IconButton(
                  icon: Icon(Icons.short_text_rounded, size: 24, color: iconColor),
                  onPressed: () {
                    setState(() {
                      _showDescription = true;
                    });
                  },
                  tooltip: '세부정보 추가',
                ),

              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.star : Icons.star_border,
                  size: 24,
                  color: _isFavorite ? Colors.amber : iconColor,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
                tooltip: '중요 표시',
              ),

              // 마감일 버튼
              IconButton(
                icon: Icon(
                  Icons.calendar_today_outlined,
                  size: 22,
                  color: _dueDate != null 
                      ? const Color(0xFFFF5722) 
                      : iconColor,
                ),
                onPressed: _selectDueDate,
                tooltip: '마감일 설정',
              ),

              const Spacer(),

              TextButton(
                onPressed: _titleController.text.trim().isEmpty ? null : saveToDo,
                child: Text(
                  '저장',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _titleController.text.trim().isEmpty
                        ? (isDark ? Colors.white30 : Colors.grey)
                        : const Color(0xFF1A73E8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isOverdue() {
    if (_dueDate == null) return false;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueOnly = DateTime(_dueDate!.year, _dueDate!.month, _dueDate!.day);
    return dueOnly.isBefore(today);
  }
}
