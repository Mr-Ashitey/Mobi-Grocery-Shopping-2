import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<bool?> confirmDialog(BuildContext context) async {
  return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text("Are You Sure?"),
          actions: [
            TextButton(
                onPressed: () => context.pop(false), child: const Text("No")),
            TextButton(
                onPressed: () => context.pop(true), child: const Text("Yes")),
          ],
        );
      });
}
