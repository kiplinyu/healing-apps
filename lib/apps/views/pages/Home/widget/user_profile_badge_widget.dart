import 'package:flutter/material.dart';

/// A widget that displays a user's avatar and name inside a capsule-shaped card.
///
/// This widget is typically used in an AppBar or a header section.
class UserProfileBadgeWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final VoidCallback? onTap;

  const UserProfileBadgeWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Menggunakan Material agar efek ripple dari InkWell terlihat bagus
    // dan sesuai dengan bentuk card.
    return Material(
      color: Colors.white,
      // StadiumBorder() secara otomatis membuat bentuk kapsul yang sempurna.
      shape: const StadiumBorder(),
      clipBehavior:
          Clip.antiAlias, // Memastikan konten di dalamnya terpotong rapi
      child: InkWell(
        onTap: onTap,
        child: Padding(
          // Memberi sedikit ruang di dalam card
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Row(
            // mainAxisSize.min membuat Row hanya memakan tempat seperlunya.
            mainAxisSize: MainAxisSize.min,
            children: [
              // Avatar Pengguna
              CircleAvatar(
                radius: 18, // Ukuran avatar
                backgroundImage: AssetImage(imageUrl),
              ),
              const SizedBox(width: 12), // Jarak antara avatar dan nama
              // Nama Pengguna
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A1A),
                ),
              ),
              const SizedBox(width: 8), // Sedikit ruang tambahan di kanan
            ],
          ),
        ),
      ),
    );
  }
}
