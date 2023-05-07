import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/config/route_path.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/grocery_list_detail_page/grocery_list_detail.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/home_screen.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mobi_grocery_shopping_2/splashscreen.dart';
import 'package:provider/provider.dart';

import 'reusable_mocks.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(String location,
      [GroceryManager? groceryListManagerProvider]) {
    final testRouter = GoRouter(
      initialLocation: location,
      routes: [
        GoRoute(
          path: RoutePath.splashRoutePath,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: RoutePath.homeRoutePath,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "${RoutePath.viewGroceryListRoutePath}/:id",
          builder: (context, state) => ViewGroceryListScreen(
            groceryListId: int.parse(state.params["id"]!),
          ),
        ),
      ],
    );
    return pumpWidget(
      ChangeNotifierProvider.value(
        value: groceryListManagerProvider ?? ReusableMocks.groceryManagerInit,
        child: MaterialApp.router(
          routerConfig: testRouter,
        ),
      ),
    );
  }
}
