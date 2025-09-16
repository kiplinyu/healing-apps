import 'package:healing_apps/apps/utils/constant/img_assets.dart';

class OnboardingItem {
  final String title;
  final String highlight;
  final String description;
  final String image;

  OnboardingItem({
    required this.title,
    required this.highlight,
    required this.description,
    required this.image,
  });
}

final onboardingItems = [
  OnboardingItem(
    title: "Life is short, make it ",
    highlight: "memorable",
    description:
        "Discover new destinations with ease — reliable tours, trusted guides, and unforgettable journeys await you.",
    image: AppAssets.onboarding1,
  ),
  OnboardingItem(
    title: "The world is waiting,  ",
    highlight: "go explore",
    description:
        "Step outside your comfort zone, embrace the beauty of new places, and let every trip tell your story.",
    image: AppAssets.onboarding2,
  ),
  OnboardingItem(
    title: "Every journey ",
    highlight: "changes you",
    description:
        "Travel isn’t just about places — it’s about experiences, people, and memories that stay with you forever.",
    image: AppAssets.onboarding3,
  ),
];
