import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/splashscreen.dart';

final router = GoRouter(
  initialLocation: '/splash_screen',
  routes: [
    GoRoute(
      path: '/splash_screen',
      builder: (context, state) => const SplashScreen(),
    ),
  ],
);
