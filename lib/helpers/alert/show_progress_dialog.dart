import 'package:flutter/material.dart';

void showProgressDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return const CircularProgressIndicator.adaptive();
      });
}
