import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingBottomSheetWidget extends ConsumerStatefulWidget {
  final Destination destination;

  const BookingBottomSheetWidget({super.key, required this.destination});

  @override
  ConsumerState<BookingBottomSheetWidget> createState() =>
      _BookingBottomSheetWidgetState();
}

class _BookingBottomSheetWidgetState
    extends ConsumerState<BookingBottomSheetWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int _ticketQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // --- Accordion untuk Date Picker ---
          _buildDatePicker(),

          const SizedBox(height: 16),

          // --- Ticket Quantity Stepper ---
          _buildQuantityStepper(),

          const SizedBox(height: 24),

          // --- Tombol Add to Cart ---
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _addToCart,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.whiteText,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Add to Cart'),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk membuat accordion date picker
  Widget _buildDatePicker() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: ExpansionTile(
        shape: const Border(), // Menghilangkan border default
        title: Row(
          children: [
            const Icon(
              PhosphorIconsRegular.calendar,
              color: AppColors.placeholder,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choose a Date',
                  style: TextStyle(fontSize: 14, color: AppColors.text),
                ),
                const SizedBox(height: 4),
                Text(
                  DateFormat('dd MMM yyyy').format(_selectedDay),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.text,
                  ),
                ),
              ],
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime.now().add(const Duration(days: 365)),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Widget untuk membuat quantity stepper
  Widget _buildQuantityStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Row(
            children: [
              Icon(PhosphorIconsRegular.ticket, color: AppColors.placeholder),
              SizedBox(width: 16),
              Text(
                'Ticket Quantity',
                style: TextStyle(fontSize: 16, color: AppColors.text),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(PhosphorIconsRegular.minus),
                onPressed: () {
                  if (_ticketQuantity > 1) {
                    setState(() => _ticketQuantity--);
                  }
                },
              ),
              Text(
                '$_ticketQuantity',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(PhosphorIconsRegular.plus),
                onPressed: () {
                  setState(() => _ticketQuantity++);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Fungsi untuk menambahkan item ke keranjang
  void _addToCart() {
    // 1. Buat objek CartItem baru
    final newItem = CartItem(
      destination: widget.destination,
      selectedDate: _selectedDay,
      quantity: _ticketQuantity,
    );

    // 2. Panggil notifier untuk menambahkan item
    ref.read(cartProvider.notifier).addToCart(newItem);

    // 3. Tutup bottom sheet
    Navigator.of(context).pop();

    // 4. (Opsional) Tampilkan notifikasi
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${widget.destination.name} added to cart!'),
        backgroundColor: Colors.green,
      ),
    );
  }
}
