import 'package:flutter/material.dart';

void showSnackBar({required BuildContext context, required String txt}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      txt,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  ));
}

String getErrorMessage(String error) {
  final RegExp regex = RegExp(r'\[(.*?)\]\s*(.*)');
  final Match? match = regex.firstMatch(error);

  if (match != null && match.groupCount >= 2) {
    return match.group(2) ?? "An unknown error occurred.";
  }

  return "An unknown error occurred.";
}
