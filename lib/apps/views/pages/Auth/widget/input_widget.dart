import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';

class InputWidget extends StatefulWidget {
  final String placeholder;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const InputWidget({
    super.key,
    required this.placeholder,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
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
      ),
    );
  }
}
