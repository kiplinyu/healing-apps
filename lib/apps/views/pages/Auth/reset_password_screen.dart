import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/password_input_widget.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _resetPassword() async {
    // Tambahkan logika reset password di sini
    final current = _currentPasswordController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    final backendService = BackendControllerService();
    
    void onSuccess() {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Password reset successful!')));
        context.go('/login');
      }
    }
    void onError(String message) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    }
    var result = await backendService.resetPassword(current, password, confirmPassword);
    
    if (result != null && result.statusCode == 200) {
      Future.delayed(const Duration(seconds: 2), onSuccess);
    } else {
      final message = result?.data['message'] ?? 'Password reset failed. Please try again.';
      onError(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
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
                  'Set New Password',
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
                  'Must be at least 8 characters',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.placeholder,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                PasswordInputWidget(
                  controller: _currentPasswordController,
                  placeholder: 'Current Password',
                ),
                const SizedBox(height: 16),

                PasswordInputWidget(
                  controller: _passwordController,
                  placeholder: 'New Password',
                ),
                const SizedBox(height: 16),

                // --- Input Password ---
                PasswordInputWidget(
                  controller: _confirmPasswordController,
                  placeholder: 'Confirm Password',
                ),
                const SizedBox(height: 32),

                // --- Tombol Reset Password ---
                ButtonWidget(
                  text: 'Reset Password',
                  isPrimary: true,
                  onPressed: _resetPassword,
                ),
                const SizedBox(height: 48),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
