import 'package:flutter/material.dart';

class ScreenPlaceHolder extends StatelessWidget {
  final String title;
  const ScreenPlaceHolder({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 0),
          const Icon(
            Icons.shopping_bag,
            size: 40,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 25),
          ),
        ],
      ),
    );
  }
}
