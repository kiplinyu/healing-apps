import 'package:healing_apps/apps/models/destination_model.dart';

/// Model untuk merepresentasikan item di dalam keranjang belanja.
class CartItem {
  final Destination destination;
  final DateTime selectedDate;
  final int quantity;

  CartItem({
    required this.destination,
    required this.selectedDate,
    required this.quantity,
  });
}
