import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/config/route_path.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/add_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/delete_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_item_usecases/update_grocery_list_item_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/add_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/delete_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/get_grocery_lists_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/domain/usecases/grocery_list_usecases/update_grocery_list_usecase.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/grocery_list_detail_page/grocery_list_detail.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/home_screen.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/provider/grocery_manager.dart';
import 'package:mobi_grocery_shopping_2/splashscreen.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

import '../feature/grocery_list/presentation/provider/grocery_manager_test.mocks.dart';

@GenerateMocks([
  GetGroceryListsUseCase,
  AddGroceryListUseCase,
  UpdateGroceryListUseCase,
  DeleteGroceryListUseCase,
  AddGroceryListItemUseCase,
  UpdateGroceryListItemUseCase,
  DeleteGroceryListItemUseCase
])
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
        value: groceryListManagerProvider ??
            GroceryManager(
                MockGetGroceryListsUseCase(),
                MockAddGroceryListUseCase(),
                MockUpdateGroceryListUseCase(),
                MockDeleteGroceryListUseCase(),
                MockUpdateGroceryListItemUseCase(),
                MockAddGroceryListItemUseCase(),
                MockDeleteGroceryListItemUseCase()),
        child: MaterialApp.router(
          routerConfig: testRouter,
        ),
      ),
    );
  }
}
