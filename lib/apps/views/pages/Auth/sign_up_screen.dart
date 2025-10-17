import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/input_widget.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/password_input_widget.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordRController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordRController.dispose();
    super.dispose();
  }

  void _signUp() {
    // Tambahkan logika sign up di sini
    final username = _usernameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;
    final repeat = _passwordRController.text;
    
    if(password != repeat){
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Password and Repeat Password do not match')));
      }
      return;
    }
    // ignore: avoid_print
    print(
      'Attempting to sign up with Username: $username, Email: $email, Password: $password',
    );

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signing up with $email...')));
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // --- Header ---
                const Text(
                  'Sign up now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SFUI',
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please fill the details and create account',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.placeholder,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                // --- Input Username ---
                InputWidget(
                  controller: _usernameController,
                  placeholder: 'Username',
                ),
                const SizedBox(height: 16),

                // --- Input Email ---
                InputWidget(controller: _emailController, placeholder: 'Email'),
                const SizedBox(height: 16),

                // --- Input Password ---
                PasswordInputWidget(
                  controller: _passwordController,
                  placeholder: 'Password',
                ),
                const SizedBox(height: 12),
                
                // --- Input Password ---
                PasswordInputWidget(
                  controller: _passwordRController,
                  placeholder: 'Repeat Password',
                ),
                const SizedBox(height: 12),

                // --- Lupa Password ---
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Logika untuk lupa password
                      context.push('/forgot-password');
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Color(0xFF0059B8),
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFUI',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // --- Tombol Sign In ---
                ButtonWidget(
                  text: 'Sign Up',
                  isPrimary: true,
                  onPressed: _signUp,
                ),
                const SizedBox(height: 48),

                // --- Link ke Sign Up ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman Sign in
                        context.go('/login');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFF0059B8),
                          fontFamily: 'SFUI',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
