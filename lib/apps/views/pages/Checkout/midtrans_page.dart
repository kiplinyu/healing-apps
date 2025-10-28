
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
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
    String? _paymentToken ;
    bool _isLoading = true;
    
    

    @override
    Widget build(BuildContext context)
    {
        // final cartItems = ref.watch(cartProvider);
        
        if(!_isLoading && _midtrans != null && _paymentToken != null)
        {
            return Scaffold(
                appBar: AppBar(title: Text('Pembayaran')),
                body: _centeredChild(
                    const Text("Memproses pembayaran..."),
                ),
            );
        }
        return Scaffold(
            appBar: AppBar(title: Text('Pembayaran')),
            body: _centeredChild(
                const CircularProgressIndicator(),
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
        Future.microtask(()
            {
                final BackendControllerService backendService = BackendControllerService();
                setState(() async {
                    _isLoading = false;
                    _paymentToken = await backendService.getToken();
                    Logger().d("Token pembayaran diterima: $_paymentToken");
                    _midtrans!.startPaymentUiFlow(
                        token: _paymentToken,
                    );
                });
            }
        );
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
        bool _isSussess = false;
        switch(result)
        {
            case "success":
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Pembayaran Berhasil")),
                );
                _isSussess = true;
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
                if(_isSussess){
                    //context.go(
                    //   '/payment-status?success=true&amount=120000&trxId=INV-123456',
                    // );
                    
                    context.go(
                        '/home'
                    );
                }else{
                    Navigator.of(context).pop();
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
