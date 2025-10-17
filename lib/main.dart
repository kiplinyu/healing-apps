import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:healing_apps/apps/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';


void main() async {
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    // Handle error if .env file loading fails
    Logger().e("Failed to load .env file: $e");
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Healing Apps',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFFEE9712)),
      ),
      routerConfig: appRouter,
    );
  }
}
