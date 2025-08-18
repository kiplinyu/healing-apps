import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/views/widgets/destination_card.dart';
import 'package:healing_apps/apps/views/widgets/wide_highlight_text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<DestinationModel> destinations = [
    DestinationModel(
      imageUrl:
          "https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1470",
      name: "Niladri Reservoir",
      rating: 4.7,
      location: "Tekergat, Sunamgnj",
      description:
          "You will get a complete travel package on the beaches. Packages in the form of airline tickets, recommended hotel rooms, transportation, and more. Experience the breathtaking view and peaceful atmosphere.",
      pricePerPerson: 59.0,
      reviewsCount: 2498,
      galleryImages: [
        "https://images.unsplash.com/photo-1439066290691-510066268af5?q=80&w=1373&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1557456170-0cf4f4d0d362?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1506536329413-d2f0d31ceb9f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1559310589-2673bfe16970?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
    ),
    DestinationModel(
      imageUrl:
          "https://images.unsplash.com/photo-1534142499731-a32a99935397?q=80&w=688",
      name: "Darma Reservoir",
      rating: 4.8,
      location: "Darma, Kuningan",
      description:
          "A beautiful reservoir surrounded by lush green hills. Perfect for picnics, fishing, and boat rides. Known for its crystal clear water and peaceful surroundings.",
      pricePerPerson: 45.0,
      reviewsCount: 1780,
      galleryImages: [
        "https://images.unsplash.com/photo-1439066290691-510066268af5?q=80&w=1373&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1557456170-0cf4f4d0d362?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1506536329413-d2f0d31ceb9f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1559310589-2673bfe16970?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
    ),
    DestinationModel(
      imageUrl:
          "https://images.unsplash.com/photo-1655337169484-d9bf5a8c5b6f?q=80&w=764",
      name: "Ranu Kumbolo",
      rating: 4.9,
      location: "Lumajang, Jawa Timur",
      description:
          "A breathtaking lake located in the Bromo Tengger Semeru National Park. Popular among hikers on the way to Mount Semeru, offering serene landscapes and camping spots.",
      pricePerPerson: 70.0,
      reviewsCount: 3120,
      galleryImages: [
        "https://images.unsplash.com/photo-1439066290691-510066268af5?q=80&w=1373&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1557456170-0cf4f4d0d362?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1506536329413-d2f0d31ceb9f?q=80&w=687&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1559310589-2673bfe16970?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1575454723382-16899c8ae4e1?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      ), // contoh profile
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      "Kiplynna",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Title
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Explore the",
                  style: TextStyle(
                    fontSize: 38,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.w300,
                  ),
                ),
                WideHighlightText(
                  textBefore: "Beautiful",
                  highlightedText: "World!",
                  textAfter: "",
                  style: TextStyle(
                    fontSize: 38,
                    fontFamily: 'SFUI',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  underlineSvgAssetPath: "assets/images/Vector 2524.svg",
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Best Destination Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Best Destination",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "View all",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Horizontal List of Destinations
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinations[index];
                  return DestinationCard(destination: destination);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
