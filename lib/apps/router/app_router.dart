// import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/pages/onboarding_screen.dart';
import 'package:healing_apps/apps/pages/splash_screen_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreenPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
  ],
);
