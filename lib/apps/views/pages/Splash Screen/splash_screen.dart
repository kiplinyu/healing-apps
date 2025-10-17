import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/services/backend_controller_service.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/utils/constant/img_assets.dart';
import 'package:logger/logger.dart';


class SplashScreen extends ConsumerStatefulWidget
{
    const SplashScreen({super.key});

    @override
    ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
{
    @override
    //NOTES: Uncomment the following code to enable automatic navigation after a delay.
    @override
    void initState()
    {
        super.initState();
        
        Future.microtask(() async {
            final BackendControllerService backendService = BackendControllerService();
            
            void goHome() => context.go('/home');
            void goSignIn() => context.go('/onboarding');
           
            try{
                final user = await backendService.getUser();
                if(user != null)
                {
                    Future.delayed(const Duration(seconds: 3), goHome);
                }
                else
                {
                    Future.delayed(const Duration(seconds: 3), goSignIn);
                }
            } catch(e)
            {
                Logger().e('Error fetching BASE_URL from .env: $e');
            }
        });
        
    }

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            backgroundColor: AppColors.backgroundSplash,
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Image.asset(AppAssets.splash, width: 280)],
                ),
            ),
        );
    }
}
