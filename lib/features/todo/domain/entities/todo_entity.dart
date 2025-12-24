class ToDoEntity {
  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
  final DateTime? dueDate;

  const ToDoEntity({
    required this.title,
    this.description,
    this.isFavorite = false,
    this.isDone = false,
    this.dueDate,
  });

  ToDoEntity copyWith({
    String? title,
    String? description,
    bool? isFavorite,
    bool? isDone,
    DateTime? dueDate,
    bool clearDueDate = false,
  }) {
    return ToDoEntity(
      title: title ?? this.title,
      description: description ?? this.description,
      isFavorite: isFavorite ?? this.isFavorite,
      isDone: isDone ?? this.isDone,
      dueDate: clearDueDate ? null : (dueDate ?? this.dueDate),
    );
  }
}
