import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/input_widget.dart';
import 'package:healing_apps/apps/views/pages/Auth/widget/success_widget.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
// Impor widget dialog yang baru kita buat

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // Mengubah fungsi ini untuk menampilkan dialog
  void _resetPassword() async {
    final email = _emailController.text;

    if (email.isNotEmpty) {
      // Langkah 1: Tampilkan dialog sukses
      _showSuccessDialog();

      // Langkah 2: Tunggu selama 2 detik
      await Future.delayed(const Duration(seconds: 2));

      // Langkah 3: Tutup dialog. Pengecekan 'mounted' penting untuk
      // memastikan widget masih ada di tree sebelum memanipulasi context.
      if (mounted) {
        // Gunakan Navigator.of(context).pop() untuk menutup dialog
        Navigator.of(context).pop();
      }

      // Langkah 4: Pindah ke halaman verifikasi OTP setelah dialog ditutup
      if (mounted) {
        context.push('/forgot-password/$email/verify');
      }
    } else {
      // Logika jika email kosong
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter your email')),
        );
      }
    }
  }

  // Fungsi baru untuk memanggil showDialog
  void _showSuccessDialog() {
    showDialog(
      context: context,
      // barrierDismissible: false, // Jika di-set false, dialog tidak bisa ditutup dengan klik di luar
      builder: (BuildContext context) {
        return const SuccessWidget(
          title: "Check your email",
          description:
              "We have send password recovery instruction to your email",
          icon: PhosphorIconsRegular.envelopeSimple,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIconsRegular.caretLeft, color: AppColors.text),
          onPressed: () {
            context.pop();
          },
        ),
      ),
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
                const SizedBox(height: 32),
                const Text(
                  'Forgot Password',
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
                  'Enter your email account to reset your password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.placeholder,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),
                InputWidget(controller: _emailController, placeholder: 'Email'),
                const SizedBox(height: 24),
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
