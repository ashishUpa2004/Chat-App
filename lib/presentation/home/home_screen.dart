import 'package:flutter/material.dart';
import 'package:messenger/data/services/service_locator.dart';
import 'package:messenger/logic/cubits/auth/auth_cubit.dart';
import 'package:messenger/presentation/screens/auth/login_screen.dart';
import 'package:messenger/router/app_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async{
              await getIt<AuthCubit>().signOut();
              getIt<AppRouter>().pushAndRemoveUntil(const LoginScreen());
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: const Center(
        child: Text("Welcome to the Home Screen!"),
      ),
    );
  }
}