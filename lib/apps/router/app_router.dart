import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/views/pages/Splash%20Screen/splash_screen.dart';
import 'package:healing_apps/apps/views/pages/login_page.dart';
import 'package:healing_apps/apps/views/pages/main_page.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/onboarding_screen.dart';
import 'package:healing_apps/apps/views/pages/register_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => OnboardingScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => MainPage(),
    ),
  ],
);
