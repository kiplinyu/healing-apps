import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// A reusable search input field widget.
///
/// This widget is designed to be "dumb", meaning it only handles the UI
/// for the search field and reports text changes via the [onChanged] callback.
/// The actual filtering logic should be implemented in the parent widget.
class SearchInputWidget extends StatelessWidget {
  /// The placeholder text to be displayed when the field is empty.
  final String hintText;

  /// A callback function that is triggered every time the text in the field changes.
  /// The parent widget can use this to get the search keyword and filter its data.
  final ValueChanged<String>? onChanged;

  /// An optional controller to manage the text field's content programmatically.
  final TextEditingController? controller;

  const SearchInputWidget({
    super.key,
    required this.hintText,
    this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        // Menggunakan hintText dari parameter agar bisa diubah-ubah
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.placeholder, fontSize: 16),

        // Menambahkan ikon pencarian di sebelah kiri
        prefixIcon: Icon(
          PhosphorIconsRegular.magnifyingGlass,
          color: AppColors.placeholder,
        ),

        // Memberi warna latar belakang pada field
        filled: true,
        fillColor: AppColors.card,

        // Menghilangkan border dan membuat sudut yang sangat melengkung (rounded)
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none, // Tidak ada garis pinggir
        ),

        // Memberi sedikit padding di dalam field agar teks tidak terlalu mepet
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
      ),
    );
  }
}
