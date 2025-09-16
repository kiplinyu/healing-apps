import 'package:flutter_riverpod/legacy.dart';
import 'package:healing_apps/apps/models/destination_model.dart';

class FavoritesNotifier extends StateNotifier<List<Destination>> {
  FavoritesNotifier() : super([]); // State awal adalah list kosong

  // Method untuk menambah/menghapus favorit
  void toggleFavorite(Destination destination) {
    // Cek apakah destinasi sudah ada di daftar favorit
    final isAlreadyFavorite = state.any((d) => d.id == destination.id);

    if (isAlreadyFavorite) {
      // Jika sudah ada, hapus dari daftar
      state = state.where((d) => d.id != destination.id).toList();
    } else {
      // Jika belum ada, tambahkan ke daftar
      state = [...state, destination];
    }
  }

  // Helper untuk mengecek status favorit dari UI
  bool isFavorite(int destinationId) {
    // ignore: unrelated_type_equality_checks
    return state.any((d) => d.id == destinationId);
  }
}

// Global provider yang akan diakses dari UI
final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<Destination>>(
      (ref) => FavoritesNotifier(),
    );
