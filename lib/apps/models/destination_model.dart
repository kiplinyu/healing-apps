/// Model untuk merepresentasikan sebuah destinasi wisata.
class Destination {
  final int id; // Diubah ke int agar lebih mudah dikelola
  final String name;
  final String location;
  final String description;
  final double price;
  final double rating;
  final List<String> categories;
  final List<String> imageUrls; // Diubah menjadi list untuk galeri
  final String? openingHours; // Opsional
  final List<String>? facilities; // Opsional
  bool isFavorite;

  Destination({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.price,
    required this.rating,
    required this.categories,
    required this.imageUrls,
    this.openingHours,
    this.facilities,
    this.isFavorite = false,
  });

  // Getter untuk gambar utama (gambar pertama di galeri)
  String get mainImageUrl => imageUrls.isNotEmpty ? imageUrls.first : '';
}
