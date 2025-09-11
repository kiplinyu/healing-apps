import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PasswordInputWidget extends StatefulWidget {
  final String placeholder;
  final TextEditingController? controller;

  const PasswordInputWidget({
    super.key,
    required this.placeholder,
    this.controller,
  });

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  // State untuk melacak apakah password sedang disembunyikan atau tidak
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      // Menyembunyikan teks berdasarkan state _isObscured
      obscureText: _isObscured,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        filled: true,
        fillColor: AppColors.card,
        hintStyle: TextStyle(color: AppColors.placeholder, fontFamily: 'SFUI'),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        // Menambahkan ikon di akhir field untuk toggle show/hide
        suffixIcon: IconButton(
          icon: Icon(
            // Mengubah ikon berdasarkan state
            _isObscured
                ? PhosphorIconsRegular.eyeSlash
                : PhosphorIconsRegular.eye,
            color: AppColors.placeholder,
          ),
          onPressed: () {
            // Memanggil setState untuk membangun ulang widget dengan state baru
            setState(() {
              _isObscured = !_isObscured;
            });
          },
        ),
      ),
    );
  }
}
