import 'package:flutter_riverpod/legacy.dart';
import 'package:healing_apps/apps/models/cart_model.dart';

// Notifier untuk mengelola state dari keranjang belanja
class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]); // State awal adalah list kosong

  // Method untuk menambahkan item ke keranjang
  void addToCart(CartItem item) {
    state = [...state, item];
  }

  // Method untuk menghapus item dari keranjang
  void removeFromCart(CartItem item) {
    state = state.where((cartItem) => cartItem != item).toList();
  }

  // Getter untuk menghitung total biaya di keranjang
  double get totalCost {
    return state.fold(
      0,
      (sum, item) => sum + (item.destination.price * item.quantity),
    );
  }
}

// Global provider yang akan diakses dari UI
final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>(
  (ref) => CartNotifier(),
);
