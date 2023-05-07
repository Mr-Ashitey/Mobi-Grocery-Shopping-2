import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobi_grocery_shopping_2/config/route_path.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer timer;
  @override
  void initState() {
    navigateToHomeScreenAfter3Seconds();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  // function to display splash screen for 3 seconds
  void navigateToHomeScreenAfter3Seconds() {
    timer = Timer(const Duration(seconds: 3), () async {
      context.go(RoutePath.homeRoutePath);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          builder: (BuildContext context, double size, Widget? child) {
            return Transform.scale(
              scale: size,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.shopping_basket_rounded,
                    size: 90,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "MOBI GROCERY SHOPPING",
                    style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 2,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
