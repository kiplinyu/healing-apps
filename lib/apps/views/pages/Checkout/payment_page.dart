import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PaymentPage extends ConsumerStatefulWidget
{
    const PaymentPage({super.key});

    @override
    ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage>
{

    bool _isLoading = true;

    late List<CartItem> cartItems;
    late double subtotal;
    late double serviceFee = 15000; // Contoh service fee
    late double totalPayment;
    late int totalItems;

    @override
    void initState() 
    {
        Future.microtask(() async
            {
                final backendService = BackendControllerService();
                final items = await backendService.getCartItems();
                setState(()
                    {
                        cartItems = items;
                        subtotal = cartItems.fold(0, (sum, item) => sum + (item.destination.price * item.quantity));
                        totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);
                        totalPayment = subtotal + serviceFee;
                        _isLoading = false;
                    }
                );
            }
        );
        super.initState();
    }
    
    
    @override
    Widget build(BuildContext context)
    {
        if (_isLoading)
        {
            return Scaffold(
                backgroundColor: AppColors.background,
                body: Center(
                    child: CircularProgressIndicator(),
                ),
            );
        }
        return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
                title: const Text(
                    'Complete Your Payment',
                    style: TextStyle(color: AppColors.text),
                ),
                backgroundColor: AppColors.background,
                elevation: 0,
                centerTitle: true,
                leading: IconButton(
                    icon: const Icon(
                        PhosphorIconsRegular.caretLeft,
                        color: AppColors.text,
                    ),
                    onPressed: () => context.go('/cart'),
                ),
            ),
            body: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                    _buildSummaryCard(totalItems, subtotal, serviceFee, totalPayment),
                    const SizedBox(height: 24),

                    // gw ubah jadi via midtrans aja di ganti jadi button Checkout ke Midtrans
                    _buildCheckoutButton(context, totalPayment),
                    
                ],
            ),
        );
    }

    Widget _buildCheckoutButton(BuildContext context, double totalPayment)
    {
        final currencyFormatter = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp. ',
            decimalDigits: 0,
        );

        return ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                ),
            ),
            child: Text(
                'Checkout Now (${currencyFormatter.format(totalPayment)})',
                // text color putih
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                ),
            ),
            onPressed: () => _checkoutPayment(),
        );
    }
    
    void _checkoutPayment() async
    {
        context.push('/midtrans-payment');
    }

    /// Widget untuk kartu ringkasan pembayaran
    Widget _buildSummaryCard(
        int totalItems,
        double subtotal,
        double serviceFee,
        double totalPayment,
    )
    {
        final currencyFormatter = NumberFormat.currency(
            locale: 'id_ID',
            symbol: 'Rp. ',
            decimalDigits: 0,
        );

        return Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    const Text(
                        'Summary Payment',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.text,
                        ),
                    ),
                    const SizedBox(height: 16),
                    _buildSummaryRow(
                        'Subtotal ($totalItems items)',
                        currencyFormatter.format(subtotal),
                    ),
                    const SizedBox(height: 8),
                    _buildSummaryRow('Service Fee', currencyFormatter.format(serviceFee)),
                    const Divider(height: 24),
                    _buildSummaryRow(
                        'Total Payment',
                        currencyFormatter.format(totalPayment),
                        isTotal: true,
                    ),
                ],
            ),
        );
    }

    /// Helper untuk membuat baris di ringkasan pembayaran
    Widget _buildSummaryRow(String label, String value, {bool isTotal = false})
    {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                    label,
                    style: TextStyle(
                        fontSize: 14,
                        color: isTotal ? AppColors.text : AppColors.placeholder,
                    ),
                ),
                Text(
                    value,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isTotal ? AppColors.primary : AppColors.text,
                    ),
                ),
            ],
        );
    }

}
