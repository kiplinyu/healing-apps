import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/views/widgets/destination_card_widget.dart';

/// A horizontal carousel widget that displays a list of destinations.
class CarouselWidget extends StatelessWidget {
  const CarouselWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // --- DATA PLACEHOLDER ---
    // Nantinya, daftar ini akan kamu dapatkan dari API/backend.
    final List<Destination> placeholderDestinations = [
      const Destination(
        id: '1',
        imageUrl:
            'https://images.unsplash.com/photo-1501785888041-af3ef285b470?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        name: 'Serenity Lake',
        location: 'Bandung, West Java',
        rating: 4.8,
      ),
      const Destination(
        id: '2',
        imageUrl:
            'https://images.unsplash.com/photo-1507525428034-b723a9ce6890?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        name: 'Hidden Beach',
        location: 'Lombok, NTB',
        rating: 4.9,
      ),
      const Destination(
        id: '3',
        imageUrl:
            'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
        name: 'Mountain Peak',
        location: 'Garut, West Java',
        rating: 4.7,
      ),
    ];

    return SizedBox(
      height: 350, // Beri tinggi tetap untuk area carousel
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: placeholderDestinations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DestinationCardWidget(
              destination: placeholderDestinations[index],
            ),
          );
        },
      ),
    );
  }
}
