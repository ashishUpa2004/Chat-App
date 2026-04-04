import 'package:flutter/material.dart';
import 'package:messenger/config/theme/app_theme.dart';
import 'package:messenger/data/services/service_locator.dart';
import 'package:messenger/presentation/screens/auth/login_screen.dart';
import 'package:messenger/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator(); 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Messenger',
      navigatorKey: getIt<AppRouter>().navigatorKey,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}

