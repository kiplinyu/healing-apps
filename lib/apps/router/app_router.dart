import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/views/pages/Auth/forgot_password_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/otp_verfiy_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/reset_password_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/sign_in_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/sign_up_screen.dart';
import 'package:healing_apps/apps/views/pages/Home/main_screen.dart';
import 'package:healing_apps/apps/views/pages/Splash%20Screen/splash_screen.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/onboarding_screen.dart';

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
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/reset-password',
      name: 'reset-password',
      builder: (context, state) => ResetPasswordScreen(),
    ),
    GoRoute(
      // Path ini sudah benar
      path: '/forgot-password/:email/verify',

      // Saran: Gunakan nama yang lebih simpel untuk referensi jika perlu
      name: 'otp-verification',

      builder: (context, state) {
        // 1. Gunakan state.pathParameters
        // 2. Beri nilai default jika email null untuk keamanan
        final email = state.pathParameters['email'] ?? 'no-email';

        // 3. Pastikan nama kelasnya benar
        return OtpVerfiyScreen(email: email);
      },
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => MainScreen(),
    ),
  ],
);
