import 'package:flutter/material.dart';

class MyAlertBox extends StatelessWidget {
  final controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String hintText;
  const MyAlertBox({
    super.key,
    this.controller,
    required this.hintText,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
        MaterialButton(
          onPressed: onCancel,
          child: const Text('Cancel'),
        )
      ],
    );
  }
}
