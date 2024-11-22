import 'package:flutter/material.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('오류'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('확인'),
        ),
      ],
    ),
  );
}

void showSuccessDialog(
    BuildContext context, String message, VoidCallback onConfirmed) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('성공'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirmed(); // 콜백 호출
          },
          child: const Text('확인'),
        ),
      ],
    ),
  );
}
