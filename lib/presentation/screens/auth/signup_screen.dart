import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:messenger/core/common/custom_button.dart';
import 'package:messenger/core/common/custom_text_field.dart';
import 'package:messenger/presentation/screens/auth/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  void _disposeControllers() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("")),
      body: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create an account",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Please fill the form to continue",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 30),
                CustomTextField(
                  controller: _nameController,
                  hintText: "Full Name",
                  prefixIcon: const Icon(Icons.person_outline),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _usernameController,
                  hintText: "Username",
                  prefixIcon: const Icon(Icons.alternate_email_outlined),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _phoneController,
                  hintText: "Phone Number",
                  prefixIcon: const Icon(Icons.phone_outlined),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  obscureText: true,
                ),
                SizedBox(height: 30),
                CustomButton(onPressed: () {}, text: "Create Account"),
                SizedBox(height: 25),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: "Sign In",
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pop(context);
                              },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
