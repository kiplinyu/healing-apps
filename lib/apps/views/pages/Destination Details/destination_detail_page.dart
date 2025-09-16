import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/providers/favorites_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/pages/Destination%20Details/widget/booking_bottom_sheet_widget.dart';
import 'package:healing_apps/apps/views/widgets/circle_button_widget.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

// 1. Ubah kembali menjadi ConsumerStatefulWidget
class DestinationDetailPage extends ConsumerStatefulWidget {
  final Destination destination;

  const DestinationDetailPage({super.key, required this.destination});

  @override
  ConsumerState<DestinationDetailPage> createState() =>
      _DestinationDetailPageState();
}

class _DestinationDetailPageState extends ConsumerState<DestinationDetailPage> {
  // 2. Buat PageController sebagai state
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    // 3. Inisialisasi controller hanya satu kali
    _pageController = PageController();
  }

  @override
  void dispose() {
    // 4. Hapus controller saat widget tidak lagi digunakan
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final destination = widget.destination; // Akses destination dari widget
    final isFavorite = ref.watch(
      favoritesProvider.select(
        (favs) => favs.any((d) => d.id == destination.id),
      ),
    );
    final favoritesNotifier = ref.read(favoritesProvider.notifier);

    final currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    final formattedPrice = currencyFormatter.format(destination.price);

    return Scaffold(
      backgroundColor: AppColors.contrast,
      body: Column(
        children: [
          // --- 1. Bagian Atas: Gambar, Header, dan Info ---
          _buildImageHeader(
            context,
            destination,
            isFavorite,
            favoritesNotifier,
            _pageController,
          ),

          // --- 2. Bagian Bawah: Konten yang bisa di-scroll ---
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                color: AppColors.card,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      children: destination.categories
                          .map(
                            (category) => Chip(
                              label: Text(category),
                              backgroundColor: AppColors.card,
                              labelStyle: const TextStyle(
                                color: AppColors.placeholder,
                              ),
                              side: BorderSide.none,
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      destination.description,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.placeholder,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: _buildBookingBar(formattedPrice, context, destination),
    );
  }

  /// Widget untuk bagian atas halaman (Gambar, Header, Info)
  Widget _buildImageHeader(
    BuildContext context,
    Destination destination,
    bool isFavorite,
    FavoritesNotifier favoritesNotifier,
    PageController pageController,
  ) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController, // Gunakan controller dari state
            itemCount: destination.imageUrls.length,
            itemBuilder: (context, index) {
              return Image.network(
                destination.imageUrls[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(color: Colors.grey),
              );
            },
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      PhosphorIconsRegular.mapPin,
                      color: AppColors.whiteText,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      destination.location,
                      style: const TextStyle(
                        color: AppColors.whiteText,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  destination.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                if (destination.imageUrls.length > 1)
                  Center(
                    child: SmoothPageIndicator(
                      controller:
                          pageController, // Gunakan controller dari state
                      count: destination.imageUrls.length,
                      effect: const ExpandingDotsEffect(
                        dotColor: AppColors.placeholder,
                        activeDotColor: AppColors.whiteText,
                        dotHeight: 8,
                        dotWidth: 16,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleButtonWidget(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: PhosphorIconsRegular.caretLeft,
                    backgroundColor: AppColors.card.withOpacity(0.8),
                  ),
                  CircleButtonWidget(
                    onPressed: () =>
                        favoritesNotifier.toggleFavorite(destination),
                    icon: isFavorite
                        ? PhosphorIconsFill.heart
                        : PhosphorIconsRegular.heart,
                    iconColor: isFavorite ? Colors.red : AppColors.contrast,
                    backgroundColor: AppColors.card.withOpacity(0.8),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk bar booking di bagian bawah
  Widget _buildBookingBar(
    String formattedPrice,
    BuildContext context,
    Destination destination,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 16,
      ).copyWith(bottom: 32),
      decoration: const BoxDecoration(color: AppColors.contrast),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                formattedPrice,
                style: const TextStyle(
                  color: AppColors.whiteText,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '/Person',
                style: TextStyle(color: AppColors.placeholder, fontSize: 14),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true, // Penting agar sheet bisa scroll
                backgroundColor: Colors.transparent, // Untuk sudut rounded
                builder: (ctx) {
                  // Panggil widget Anda di sini
                  return BookingBottomSheetWidget(destination: destination);
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.whiteText,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text('Book Now'),
          ),
        ],
      ),
    );
  }
}
