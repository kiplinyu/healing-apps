import 'dart:convert'; // Diperlukan untuk mengubah data menjadi JSON
import 'package:flutter/material.dart';
import 'package:healing_apps/apps/models/schedule.dart'; // Pastikan path model ini benar
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart'; // <-- Pastikan package ini ada di pubspec.yaml
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import package QR code

// Widget utama untuk halaman detail tiket
class TicketDetailsPage extends StatelessWidget {
  final Schedule schedule;

  const TicketDetailsPage({super.key, required this.schedule});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.contrast,
      appBar: AppBar(
        backgroundColor: AppColors.contrast,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            PhosphorIconsRegular.caretLeft,
            color: AppColors.whiteText,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Ticket Details',
          style: TextStyle(
            color: AppColors.whiteText,
            fontFamily: "SFUI",
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        // SingleChildScrollView penting untuk layar yang pendek
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: TicketWidget(schedule: schedule),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget khusus untuk membuat tampilan kartu tiket
class TicketWidget extends StatelessWidget {
  const TicketWidget({super.key, required this.schedule});

  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    // Siapkan data untuk QR Code dengan format tanggal yang benar
    final qrDataMap = {
      'destinationName': schedule.destinationName,
      'orderId': schedule.orderId,
      'entryDate': schedule.date.toIso8601String(), // Format standar untuk JSON
      'visitor': schedule.visitorName,
      'ticketCount': schedule.ticketCount,
    };
    final qrDataString = jsonEncode(qrDataMap);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Membuat Column sekecil mungkin
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  // Pastikan ini Image.asset atau Image.network
                  schedule.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.image_not_supported,
                    size: 200,
                    color: AppColors.placeholder,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      schedule.destinationName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontFamily: "SFUI",
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Adventure unlocked. This ticket is your pass to explore, discover, and enjoy the moment.',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.placeholder,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const DashedDivider(),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _buildDetailItem(
                          'Order ID',
                          schedule.orderId,
                          isChip: true,
                        ),
                        _buildDetailItem(
                          'Entry Date',
                          DateFormat('dd MMM yyyy').format(schedule.date),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildDetailItem('Visitor', schedule.visitorName),
                        _buildDetailItem(
                          'Ticket',
                          '${schedule.ticketCount}x',
                          icon: PhosphorIconsRegular.ticket,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: DashedDivider(),
              ),
              const SizedBox(height: 12),
              QrImageView(
                data: qrDataString,
                version: QrVersions.auto,
                size: 120.0,
                gapless: false,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        // Lingkaran sobekan
        Positioned(
          left: -12,
          top: 450,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.contrast,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          right: -12,
          top: 450,
          child: Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.contrast,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailItem(
    String label,
    String value, {
    bool isChip = false,
    IconData? icon,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.placeholder,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              fontFamily: "SFUI",
            ),
          ),
          const SizedBox(height: 4),
          // Menggunakan Container untuk kontrol penuh, bukan Chip
          if (isChip)
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 3.0,
              ),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: AppColors.primary.withOpacity(0.35),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Samakan ukuran font
                ),
              ),
            )
          else
            // Container kosong untuk menyamakan tinggi jika bukan chip
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 3.0,
              ), // Beri padding vertikal yg sama
              child: Row(
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 16, color: AppColors.text),
                    const SizedBox(width: 4),
                  ],
                  Flexible(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.text,
                        fontSize: 14, // Samakan ukuran font
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// Widget untuk garis putus-putus
class DashedDivider extends StatelessWidget {
  const DashedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(),
      size: const Size(double.infinity, 1),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.placeholder
      ..strokeWidth = 1;
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
