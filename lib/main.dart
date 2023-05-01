import 'package:flutter/material.dart';
import 'package:mobi_grocery_shopping_2/config/router.dart';

void main() {
  runApp(const GroceryListApp());
}

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GroceryListApp',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      // routerDelegate: router.routerDelegate,
      // routeInformationParser: router.routeInformationParser,
      // routeInformationProvider: router.routeInformationProvider,
    );
  }
}
