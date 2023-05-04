import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobi_grocery_shopping_2/config/router.dart';
import 'package:mobi_grocery_shopping_2/config/theme.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mobi_grocery_shopping_2/injection_container.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initGetIt();
  await dotenv.load();
  runApp(const GroceryListApp());
}

class GroceryListApp extends StatelessWidget {
  const GroceryListApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: locator.get<GroceryManager>(),
      child: MaterialApp.router(
        title: 'GroceryListApp',
        debugShowCheckedModeBanner: false,
        theme: customTheme,
        routerConfig: router,
      ),
    );
  }
}
