import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/button_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:pinput/pinput.dart';

class OtpVerfiyScreen extends StatefulWidget {
  // Kita bisa mengirim email ke halaman ini untuk ditampilkan
  final String email;

  const OtpVerfiyScreen({
    super.key,
    this.email = 'example@gmail.com', // Nilai default
  });

  @override
  State<OtpVerfiyScreen> createState() => _OtpVerfiyScreenState();
}

class _OtpVerfiyScreenState extends State<OtpVerfiyScreen> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Tema untuk setiap kotak PIN
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(PhosphorIconsRegular.caretLeft, color: AppColors.text),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 32),
                const Text(
                  'OTP Verification',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please check your email ${widget.email} to see the verification code',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.placeholder,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 48),

                // --- WIDGET PINPUT ---
                Pinput(
                  length: 4,
                  controller: pinController,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  // Tema saat kotak di-fokus
                  focusedPinTheme: defaultPinTheme.copyWith(
                    decoration: defaultPinTheme.decoration!.copyWith(
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                  ),
                  // Tema saat semua kotak sudah terisi
                  submittedPinTheme: defaultPinTheme,
                  onCompleted: (pin) {
                    // Logika saat 4 digit sudah dimasukkan
                    // ignore: avoid_print
                    print('OTP yang dimasukkan: $pin');
                  },
                ),

                const SizedBox(height: 32),
                ButtonWidget(
                  text: 'Verify',
                  isPrimary: true,
                  onPressed: () {
                    // Logika verifikasi di sini
                    final otp = pinController.text;
                    // ignore: avoid_print
                    print('Tombol Verify ditekan dengan OTP: $otp');

                    context.go('/reset-password');
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Resend code to',
                      style: TextStyle(color: AppColors.placeholder),
                    ),
                    const Spacer(),
                    const Text(
                      '01:26', // Placeholder untuk timer
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w600,
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
