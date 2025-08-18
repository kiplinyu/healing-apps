import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/views/pages/destination_page.dart';

class DestinationCard extends StatelessWidget {
  final DestinationModel destination;

  const DestinationCard({super.key, required this.destination});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                DestinationDetailPage(destination: destination),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Container(
          width: 240,
          height: 380,
          margin: const EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).shadowColor.withAlpha(25),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gambar
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      destination.imageUrl,
                      width: 240,
                      height: 265,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 8,
                      top: 8,
                      child: _buildCircleButton(
                        icon: Icons.bookmark_border,
                        iconColor: Colors.white,
                        backgroundColor: Colors.black.withAlpha(
                          (0.5 * 255).toInt(),
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),

              // Info
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Nama & rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              destination.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                destination.rating.toString(),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Deskripsi singkat + Read more
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: _shortDescription(destination.description),
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                              ),
                            ),
                            const TextSpan(text: " "),
                            const TextSpan(
                              text: "Read more...",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      // Alamat
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 14,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              destination.location,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Potong deskripsi biar cuma tampil secukupnya
  String _shortDescription(String fullText) {
    const maxChars = 60;
    if (fullText.length <= maxChars) return fullText;
    return fullText.substring(0, maxChars);
  }
}

Widget _buildCircleButton({
  required IconData icon,
  required VoidCallback onTap,
  Color iconColor = Colors.black,
  Color backgroundColor = Colors.white,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(50),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, size: 20, color: iconColor),
    ),
  );
}
