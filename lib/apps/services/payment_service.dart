// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:healing_apps/apps/models/cart_model.dart';

class PaymentService {
  // Ganti dengan URL endpoint di backend Anda
  final String _backendUrl = 'https://your-backend.com/create-transaction';
  final Dio _dio = Dio(); // 1. Buat instance Dio

  /// Mengirim detail transaksi ke backend menggunakan Dio.
  Future<String?> createTransaction(List<CartItem> cartItems) async {
    // Hitung total biaya dari item di keranjang
    final double totalAmount = cartItems.fold(
      0,
      (sum, item) => sum + (item.destination.price * item.quantity),
    );

    try {
      // 2. Siapkan data yang akan dikirim (sebagai Map, tidak perlu jsonEncode)
      final data = {
        'total_amount': totalAmount,
        'item_details': cartItems
            .map(
              (item) => {
                'id': item.destination.uuid,
                'price': item.destination.price,
                'quantity': item.quantity,
                'name': item.destination.name,
              },
            )
            .toList(),
        'customer_details': {
          'first_name': 'Kiplinyu',
          'email': 'kiplinyu@gmail.com',
        },
      };

      // 3. Kirim request POST menggunakan dio
      final response = await _dio.post(
        _backendUrl,
        data: data, // Kirim Map langsung di properti 'data'
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      // 4. Proses respons
      if (response.statusCode == 200) {
        // Dio otomatis melakukan decode JSON, jadi bisa langsung akses response.data
        final snapToken = response.data['snap_token'];
        return snapToken;
      } else {
        print('Failed to create transaction: ${response.data}');
        return null;
      }
    } on DioException catch (e) {
      // 5. Tangani error spesifik dari Dio (misal: koneksi, timeout, dll.)
      print('Error in PaymentService (Dio): ${e.response?.data ?? e.message}');
      return null;
    } catch (e) {
      // Tangani error lainnya
      print('An unexpected error occurred: $e');
      return null;
    }
  }
}
