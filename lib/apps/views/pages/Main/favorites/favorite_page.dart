import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/providers/favorites_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/utils/constant/img_assets.dart';
import 'package:healing_apps/apps/views/widgets/glass_destination_card_widget.dart';
import 'package:healing_apps/apps/views/widgets/not_found_widget.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';

// 1. Ubah menjadi ConsumerStatefulWidget untuk menangani state pencarian
class FavoritePage extends ConsumerStatefulWidget {
  const FavoritePage({super.key});

  @override
  ConsumerState<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends ConsumerState<FavoritePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // 2. Ambil data favorit langsung dari provider
    final allFavorites = ref.watch(favoritesProvider);

    // 3. Logika filter tetap sama, tapi sumber datanya dari provider
    final filteredFavorites = allFavorites.where((destination) {
      if (_searchQuery.isEmpty) {
        return true;
      }
      return destination.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: allFavorites.isEmpty
            ? const NotFoundWidget(
                text:
                    "You haven't saved any destinations yet. Let's find some!",
                imagePath: AppAssets.notFoundFavorite,
                buttonText: "Explore Now",
              )
            : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              'Semua destinasi yang kamu tandai bakal selalu ada di sini. Siap pilih kapan mau jalan?',
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.placeholder,
                                fontFamily: "SFUI",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 24),
                          SearchInputWidget(
                            hintText: 'Cari yang sudah kamu simpan...',
                            onChanged: (query) {
                              setState(() {
                                _searchQuery = query;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  // 4. Tampilkan daftar favorit yang sudah difilter
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final destination = filteredFavorites[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: SizedBox(
                            height: 325,
                            child: GlassDestinationCardWidget(
                              destination: destination,
                            ),
                          ),
                        );
                      }, childCount: filteredFavorites.length),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
