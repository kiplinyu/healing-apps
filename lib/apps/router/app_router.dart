import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/models/schedule.dart';
import 'package:healing_apps/apps/views/pages/Auth/forgot_password_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/otp_verfiy_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/reset_password_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/sign_in_screen.dart';
import 'package:healing_apps/apps/views/pages/Auth/sign_up_screen.dart';
import 'package:healing_apps/apps/views/pages/Checkout/payment_page.dart';
import 'package:healing_apps/apps/views/pages/Destination%20Details/destination_detail_page.dart';
import 'package:healing_apps/apps/views/pages/Main/main_screen.dart';
import 'package:healing_apps/apps/views/pages/Main/profile/edit_profile_page.dart';
import 'package:healing_apps/apps/views/pages/Main/schedule/ticket_details_page.dart';
import 'package:healing_apps/apps/views/pages/Splash%20Screen/splash_screen.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/onboarding_screen.dart';
import 'package:healing_apps/apps/views/pages/cart/cart_page.dart';
import 'package:healing_apps/apps/views/widgets/payment_callback_widget.dart';

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
    GoRoute(
      path: '/edit-profile',
      name: 'edit-profile',
      builder: (context, state) => EditProfilePage(),
    ),
    GoRoute(
      path: '/ticket-details',
      builder: (context, state) {
        // Mengambil objek 'schedule' yang dikirim sebagai 'extra'
        
        final item = state.extra as CartItem;
        final schedule = Schedule(
          id: item.destination.uuid,
          destinationName: item.destination.name,
          imageUrl: item.destination.imageUrls[0],
          date: item.selectedDate,
          orderId: item.order_id ?? "ERROR", // Contoh data statis
          visitorName: item.userModel.name, // Contoh data statis
          ticketCount: item.quantity,
        );
        return TicketDetailsPage(schedule: schedule);
      },
    ),
    GoRoute(
      path: '/destination-details',
      builder: (context, state) {
        // Pastikan data 'extra' dikirim dan tipenya benar
        if (state.extra is Destination) {
          final destination = state.extra as Destination;
          return DestinationDetailPage(destination: destination);
        }
        // Fallback jika data tidak ada
        return const Scaffold(
          body: Center(child: Text('Error: Data not found')),
        );
      },
    ),
    // Di file konfigurasi GoRouter Anda
    GoRoute(
      path: '/cart',
      builder: (context, state) {
        // Tidak perlu passing data, langsung return halamannya
        return const CartPage();
      },
    ),
    GoRoute(
      path: '/payment',
      builder: (context, state) {
        // Tidak perlu passing data, langsung return halamannya
        return const PaymentPage();
      },
    ),
    
    // this route is deprecated
    // GoRoute(
    //   path: '/midtrans-payment',
    //   builder: (context, state) {
    //     // Tidak perlu passing data, langsung return halamannya
    //     return PaymentWebView();
    //   },
    // ),
    GoRoute(
      path: '/payment-status',
      builder: (context, state) {
        // Ambil data yang dikirim sebagai query parameters
        final isSuccess = state.uri.queryParameters['success'] == 'true';
        final amount = double.tryParse(
          state.uri.queryParameters['amount'] ?? '0',
        );
        final trxId = state.uri.queryParameters['trxId'] ?? 'N/A';

        return PaymentCallbackWidget(
          isSuccess: isSuccess,
          amount: amount ?? 0,
          transactionId: trxId,
        );
      },
    ),
  ],
);
