import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/views/widgets/destination_card_widget.dart';

import '../../../../../providers/destination_provider.dart';

/// A horizontal carousel widget that displays destinations using DestinationCardWidget.
class CarouselWidget extends ConsumerWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ambil data langsung dari dummy_data.dart
    final carouselItems = ref.watch(getDestinationsProvider).value ?? [];

    return SizedBox(
      height: 350, // Disesuaikan dengan tinggi DestinationCardWidget
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: carouselItems.length,
        itemBuilder: (context, index) {
          final destination = carouselItems[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            // Cukup berikan 'destination', karena widget sudah terhubung ke Riverpod
            child: DestinationCardWidget(destination: destination),
          );
        },
      ),
    );
  }
}
