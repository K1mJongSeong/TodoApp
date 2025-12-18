import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _titleFocusNode.requestFocus();
    });
  }

  void saveToDo() {
    if (_titleController.text.trim().isEmpty) return;

    final todo = ToDoEntity(
      title: _titleController.text.trim(),
      description:
      _showDescription ? _descriptionController.text.trim() : null,
      isFavorite: _isFavorite,
    );

    Navigator.of(context).pop(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 12,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            focusNode: _titleFocusNode,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => saveToDo(),
            style: const TextStyle(fontSize: 16),
            decoration: const InputDecoration(
              hintText: '새 할 일',
              border: InputBorder.none,
            ),
            onChanged: (_) => setState(() {}),
          ),

          const SizedBox(height: 12),

          if (_showDescription)
            Expanded(
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                style: const TextStyle(fontSize: 14),
                decoration: const InputDecoration(
                  hintText: '세부정보 추가',
                  border: InputBorder.none,
                ),
              ),
            ),

          const SizedBox(height: 12),

          Row(
            children: [
              if (!_showDescription)
                IconButton(
                  icon: const Icon(Icons.short_text_rounded, size: 24),
                  onPressed: () {
                    setState(() {
                      _showDescription = true;
                    });
                  },
                ),

              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.star : Icons.star_border,
                  size: 24,
                ),
                onPressed: () {
                  setState(() {
                    _isFavorite = !_isFavorite;
                  });
                },
              ),

              const Spacer(),

              TextButton(
                onPressed: _titleController.text.trim().isEmpty
                    ? null
                    : saveToDo,
                child: Text(
                  '저장',
                  style: TextStyle(
                    color: _titleController.text.trim().isEmpty
                        ? Colors.grey
                        : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
