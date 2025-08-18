class DestinationModel {
  final String imageUrl;
  final String name;
  final double rating;
  final String location;
  final String description;
  final double pricePerPerson;
  final int reviewsCount;
  final List<String> galleryImages;

  DestinationModel({
    required this.imageUrl,
    required this.name,
    required this.rating,
    required this.location,
    required this.description,
    required this.pricePerPerson,
    required this.reviewsCount,
    required this.galleryImages,
  });
}
