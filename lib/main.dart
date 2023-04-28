import 'package:flutter/material.dart';

void main() {
  runApp(const GroceryListApp());
}

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GroceryListApp',
      debugShowCheckedModeBanner: false,
    );
  }
}
