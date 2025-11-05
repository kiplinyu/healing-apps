import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/utils/constant/img_assets.dart';
import 'package:healing_apps/apps/views/pages/Main/schedule/widget/schedule_card_widget.dart';
import 'package:healing_apps/apps/views/widgets/not_found_widget.dart';
import 'package:healing_apps/apps/views/widgets/search_input_widget.dart';

// 1. Ubah menjadi ConsumerStatefulWidget
class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

//TODO: onGo to ticket details page with cart item data from URL
class _SchedulePageState extends ConsumerState<SchedulePage> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    // 2. Ambil data dari cartProvider
    final allSchedules = ref.watch(cartProvider);

    // 3. Logika filter langsung di dalam build method
    final filteredSchedules = allSchedules.where((item) {
      if (_searchQuery.isEmpty) {
        return true;
      }
      return item.destination.name.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: filteredSchedules.isEmpty && _searchQuery.isEmpty
            // --- KONDISI JIKA JADWAL KOSONG ---
            ? const NotFoundWidget(
                text:
                    "Your schedule is empty. Let's book an unforgettable journey! ON GOING COKK",
                imagePath: AppAssets.notFoundSchedule,
                buttonText: "Explore Now",
              )
            // --- KONDISI JIKA ADA JADWAL ---
            : CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(16.0),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hey Kiplinyu,',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Exciting journeys are already booked for you',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          SearchInputWidget(
                            hintText: 'Search your booked destination...',
                            onChanged: (query) {
                              setState(() {
                                _searchQuery = query;
                              });
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Your upcoming event',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final cartItem = filteredSchedules[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ScheduleCardWidget(
                          cartItem: cartItem,
                          onShowTicket: () {
                            // Kirim CartItem ke halaman detail tiket
                            context.push('/ticket-details', extra: cartItem);
                          },
                          onRemove: () {
                            // Panggil method di notifier untuk menghapus
                            ref
                                .read(cartProvider.notifier)
                                .removeFromCart(cartItem);
                          },
                        ),
                      );
                    }, childCount: filteredSchedules.length),
                  ),
                ],
              ),
      ),
    );
  }
}
