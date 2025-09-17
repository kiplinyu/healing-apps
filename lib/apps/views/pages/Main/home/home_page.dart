import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/providers/favorites_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Main/data/dummy_data.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/carousel_widget.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/filter_badge_widget.dart';
import 'package:healing_apps/apps/views/widgets/glass_destination_card_widget.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/user_profile_badge_widget.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

// 1. Ubah menjadi ConsumerWidget untuk bisa 'mendengarkan' provider
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. Tambahkan WidgetRef
    final List<String> categories = [
      'All',
      'Destination',
      'Hotel',
      'Food',
      'Culture',
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          children: [
            // --- Bagian Header: Profil dan Tombol Keranjang ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  UserProfileBadgeWidget(
                    imageUrl:
                        'assets/images/profile.jpg', // Ganti dengan path yg benar
                    name: 'kiplinyu',
                    onTap: () => context.go('/profile'), // Navigasi ke profil
                  ),
                  CircleButtonWidget(
                    onPressed: () => context.push('/cart'),
                    icon: PhosphorIconsRegular.shoppingCart,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // --- Judul Utama ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'SFUI',
                    color: AppColors.text,
                    height: 1.2,
                  ),
                  children: [
                    TextSpan(text: 'Mau '),
                    TextSpan(
                      text: 'Jalan ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    TextSpan(text: 'ke Mana\nHari Ini?'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // --- Input Pencarian ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchInputWidget(
                hintText: 'Ketik tujuan perjalananmu...',
                onChanged: (value) {
                  // TODO: Implement search logic
                },
              ),
            ),
            const SizedBox(height: 24),

            // --- Judul Sub-bagian ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Best Destination',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),

            // --- Carousel Destinasi (Sudah terhubung ke Riverpod) ---
            const CarouselWidget(),
            const SizedBox(height: 24),

            // --- Filter Kategori ---
            FilterBadgeWidget(
              categories: categories,
              onCategorySelected: (category) {
                // TODO: Implement filter logic
              },
            ),
            const SizedBox(height: 16),

            // --- Daftar Kartu Kaca ---
            ListView.builder(
              itemCount: dummyDestinations.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final destination = dummyDestinations[index];

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: SizedBox(
                    height: 325,
                    child: GlassDestinationCardWidget(destination: destination),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
