import 'package:flutter/material.dart';

class NoToDo extends StatelessWidget {
  const NoToDo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        '할 일이 없습니다.\n새 할 일을 추가해보세요!',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }
}
