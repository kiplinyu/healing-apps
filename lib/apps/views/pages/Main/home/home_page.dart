import 'package:flutter/material.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Main/data/dummy_data.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/carousel_widget.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/filter_badge_widget.dart';
import 'package:healing_apps/apps/views/widgets/glass_destination_card_widget.dart';
import 'package:healing_apps/apps/views/pages/Main/home/widget/user_profile_badge_widget.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

/// The main content view for the Home tab.
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _categories = [
    'All',
    'Destination',
    'Hotel',
    'Food',
    'Culture',
  ];
  // ignore: unused_field
  String _selectedCategory = 'All';

  // State untuk melacak item favorit
  final Set<String> _favoriteIds = {};

  void _toggleFavorite(String destinationId) {
    setState(() {
      if (_favoriteIds.contains(destinationId)) {
        _favoriteIds.remove(destinationId);
      } else {
        _favoriteIds.add(destinationId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Struktur yang lebih rapi: Scaffold -> SafeArea -> ListView
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
                    imageUrl: 'assets/images/profile.jpg',
                    name: 'kiplinyu',
                    onTap: () {},
                  ),
                  CircleButtonWidget(
                    onPressed: () {},
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
                        color: Colors.orange,
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
                onChanged: (value) {},
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

            // --- Carousel Destinasi ---
            const CarouselWidget(),
            const SizedBox(height: 24),

            // --- Filter Kategori ---
            FilterBadgeWidget(
              categories: _categories,
              onCategorySelected: (category) {
                setState(() {
                  _selectedCategory = category;
                });
                // Tambahkan logika filter di sini
              },
            ),
            const SizedBox(height: 16),

            // --- Daftar Kartu Kaca ---
            // Menggunakan ListView.builder untuk menampilkan semua data dummy
            ListView.builder(
              itemCount: dummyDestinations.length,
              shrinkWrap: true, // Penting karena berada di dalam ListView lain
              physics:
                  const NeverScrollableScrollPhysics(), // Mencegah scroll ganda
              itemBuilder: (context, index) {
                final destination = dummyDestinations[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: SizedBox(
                    // width: 150,
                    height: 350,
                    child: GlassDestinationCardWidget(
                      imageUrl: destination.imageUrl,
                      name: destination.name,
                      location: destination.location,
                      rating: destination.rating,
                      isFavorite: _favoriteIds.contains(destination.id),
                      onFavoriteTap: () {
                        _toggleFavorite(destination.id);
                      },
                    ),
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
