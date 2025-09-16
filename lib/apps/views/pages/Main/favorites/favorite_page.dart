import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "Semua destinasi yang kamu tandai bakal selalu ada di sini. Siap pilih kapan mau jalan?",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'SFUI',
                color: AppColors.placeholder,
              ),
              textAlign: TextAlign.center,
            ),
            SearchInputWidget(hintText: "Cari yang sudah kamu simpan..."),
          ],
        ),
      ),
    );
  }
}
