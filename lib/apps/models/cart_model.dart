import 'package:healing_apps/apps/models/destination_model.dart';
import 'package:healing_apps/apps/models/user_model.dart';

/// Model untuk merepresentasikan item di dalam keranjang belanja.
class CartItem {
  late String? order_id;
  final Destination destination;
  final DateTime selectedDate;
  final int quantity;
  final UserModel userModel;

  CartItem({
    this.order_id,
    required this.userModel,
    required this.destination,
    required this.selectedDate,
    required this.quantity,
  });
}
