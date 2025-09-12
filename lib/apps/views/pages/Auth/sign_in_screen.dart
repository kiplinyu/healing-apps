import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/input_widget.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/password_input_widget.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signIn() {
    // Tambahkan logika sign in di sini
    final email = _emailController.text;
    final password = _passwordController.text;
    // ignore: avoid_print
    print('Attempting to sign in with Email: $email, Password: $password');

    // Pengecekan 'mounted' penting untuk menghindari error jika widget sudah ter-dispose
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signing in with $email...')));
    }

    context.go('/home'); // Navigasi ke halaman home setelah sign in
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          // Padding dipindahkan ke dalam agar tidak ikut ter-scroll
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          // 2. ConstrainedBox untuk membatasi lebar maksimum dari konten.
          //    Ini membuat tampilan di tablet tidak terlalu melebar.
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500, // Anda bisa menyesuaikan nilai ini
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                // --- Header ---
                const Text(
                  'Sign in now',
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
                  'Please sign in to continue our app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.placeholder,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                // --- Input Email ---
                InputWidget(controller: _emailController, placeholder: 'Email'),
                const SizedBox(height: 16),

                // --- Input Password ---
                PasswordInputWidget(
                  controller: _passwordController,
                  placeholder: 'Password',
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
                  text: 'Sign In',
                  isPrimary: true,
                  onPressed: _signIn,
                ),
                const SizedBox(height: 48),

                // --- Link ke Sign Up ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigasi ke halaman Sign Up
                        context.go('/register');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        alignment: Alignment.centerLeft,
                      ),
                      child: const Text(
                        'Sign Up',
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
