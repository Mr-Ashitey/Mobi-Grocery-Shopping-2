import 'package:flutter/material.dart';

void showProgressDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) {
        return const CircularProgressIndicator.adaptive();
      });
}

class CustomProgressIndicator extends StatelessWidget {
  const CustomProgressIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }
}
