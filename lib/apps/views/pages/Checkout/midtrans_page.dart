
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:midtrans_sdk/midtrans_sdk.dart';

// import '../../../providers/cart_provider.dart';

class PaymentWebView extends ConsumerStatefulWidget
{
    @override
    ConsumerState<PaymentWebView> createState() => _PaymentWebViewState();
}


class _PaymentWebViewState extends ConsumerState<PaymentWebView>
{
    MidtransSDK? _midtrans;
    bool _isLoading = true;

    @override
    Widget build(BuildContext context)
    {
        // final cartItems = ref.watch(cartProvider);
        final String token = 'fc7f82a7-f710-4360-bd33-7954b9cf53ba';
        return Scaffold(
            appBar: AppBar(title: Text('Pembayaran')),
            body: _centeredChild(
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: ()
                        {
                            _midtrans?.startPaymentUiFlow(
                                token: token,
                            );
                        },
                        child: const Text('Bayar Sekarang'),
                    ),
            ),
        );
    }

    Widget _centeredChild(Widget child)
    {
        return Center(
            child: child,
        );
    }

    @override
    void initState() 
    {
        super.initState();
        WidgetsBinding.instance.addPostFrameCallback((_) => _initSDK());
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
        switch(result)
        {
            case "success":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Berhasil")),
                );
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
            default:
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Status Pembayaran Tidak Diketahui")),
                );
        }
        
        // wait for 2 seconds before popping
        Future.delayed(const Duration(seconds: 2), ()
        {            
            if(mounted)
            {
                Navigator.of(context).pop();
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
