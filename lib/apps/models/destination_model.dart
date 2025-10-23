import 'dart:convert';


/// Model untuk merepresentasikan sebuah destinasi wisata.
class Destination
{
    final String uuid; // Diubah ke int agar lebih mudah dikelola
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
        required this.uuid,
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

    factory Destination.fromJson(Map<String, dynamic> json){
        return Destination(
            uuid: json['uuid'],
            name: json['name'],
            location: json['location'],
            description: json['description'],
            price: double.tryParse(json['price'].toString()) ?? 0.0,
            rating: (json['rating'] is num)
                ? (json['rating'] as num).toDouble()
                : double.tryParse(json['rating'].toString()) ?? 0.0,
            categories: List<String>.from(jsonDecode(json['categories']) ?? []),
            imageUrls: List<String>.from(jsonDecode(json['image_urls']) ?? []),
            openingHours: json['opening_hours'] ?? 'Tidak tersedia',
            facilities: json['facilities'] != null
                ? List<String>.from(json['facilities'])
                : null,
            isFavorite: json['is_favorite'] ?? false,
        );
    }
}
