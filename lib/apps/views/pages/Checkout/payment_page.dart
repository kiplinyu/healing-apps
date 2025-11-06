import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/models/cart_model.dart';
import 'package:healing_apps/apps/providers/cart_provider.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';
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
    late double subtotal = 0;
    late double serviceFee = 15000; // Contoh service fee
    late double totalPayment = 0;
    late int totalItems = 0;

    MidtransSDK? _midtrans;
    String? _paymentToken ;

    @override
    void initState() 
    {
        Future.microtask(() async
            {
                final backendService = BackendControllerService();
                final items = await backendService.getCartItems();
                _paymentToken = await backendService.getToken();
                setState(()
                    {
                        cartItems = items;
                        subtotal = cartItems.fold(0, (sum, item) => sum + (item.destination.price * item.quantity));
                        totalItems = cartItems.fold(0, (sum, item) => sum + item.quantity);
                        totalPayment = subtotal + serviceFee;

                        
                        Logger().d("Token pembayaran diterima: $_paymentToken");
                        _isLoading = false;
                    }
                );
            }
        );
        WidgetsBinding.instance.addPostFrameCallback((_) => _initSDK());
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
        
        // i think we dont need this anymore
        // final currencyFormatter = NumberFormat.currency(
        //     locale: 'id_ID',
        //     symbol: 'Rp. ',
        //     decimalDigits: 0,
        // );
        
        
        // this condition to check if midtrans is still loading or payment token is null
        // then show loading button
        if(_isLoading || _midtrans == null || _paymentToken == null)
        {
            return ElevatedButton(
                onPressed: null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary.withOpacity(0.6),
                    foregroundColor: AppColors.whiteText,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                    ),
                ),
                child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteText),
                ),
            );
        }else {
            return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                    ),
                ),
                child: Text(
                    'Checkout',
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
    }
    
    void _checkoutPayment() async
    {
        _midtrans!.startPaymentUiFlow(
            token: _paymentToken,
        );
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

    void _initSDK() async
    {
        _isLoading = true;
        Logger().d("Inisialisasi Midtrans SDK...");
        final colorScheme = Theme.of(context).colorScheme; // aman di sini
        var config = MidtransConfig(
            clientKey: dotenv.env['MIDTRANS_CLIENT_KEY'] ?? '',
            merchantBaseUrl: "https://example.com/",
            enableLog: false,
            colorTheme: ColorTheme(
                colorPrimary: colorScheme.primary,
                colorPrimaryDark: colorScheme.primary,
                colorSecondary: colorScheme.secondary,
            ),
        );
        _midtrans = await MidtransSDK.init(config: config);
        _midtrans!.setTransactionFinishedCallback((result)
        {
            Logger().d("Hasil transaksi: ${result.status}");
            _paymentCallback(result.status.toString());
        }
        );

        if (_midtrans == null)
        {
            Logger().e("Gagal inisialisasi Midtrans SDK");
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Gagal inisialisasi Midtrans SDK")),
            );
        }
        else
        {
            setState(() {
                _isLoading = false;
            });
            Logger().d("Midtrans SDK siap digunakan");
        }
    }

    void _paymentCallback(String result)
    {
        bool isSussess = false;
        switch(result)
        {
            case "success":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Berhasil")),
                );
                isSussess = true;
                break;
            case "pending":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Tertunda")),
                );
                break;
            case "failed":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Gagal")),
                );
                break;
            case "canceled":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Dibatalkan")),
                );
                break;
            case "invalid":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Tidak Valid")),
                );
                break;
            case 'settlement':
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Ini sudah selesai dari pihak Midtrans")),
                );
                isSussess = true;
                break;
            default:
                // popup center
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Status Pembayaran Tidak Diketahui")),
                );
                break;
        }

        // wait for 2 seconds before popping
        Future.delayed(const Duration(seconds: 2), ()
        {
            if(mounted)
            {
                if(isSussess){
                    context.go(
                        '/home'
                    );
                }
            }
        });
    }


    @override
    void dispose()
    {
        _midtrans?.removeTransactionFinishedCallback();
        super.dispose();
    }

}
