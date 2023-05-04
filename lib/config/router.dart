import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/config/route_path.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/grocery_list_detail_page/grocery_list_detail.dart';
import 'package:mobi_grocery_shopping_2/features/grocery_list/presentation/pages/home_page/home_screen.dart';
import 'package:mobi_grocery_shopping_2/splashscreen.dart';

final router = GoRouter(
  initialLocation: RoutePath.splashRoutePath,
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
