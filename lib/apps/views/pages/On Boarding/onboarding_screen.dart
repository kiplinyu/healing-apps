import 'package:flutter/material.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/widget/back_circle_button_widget.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/widget/button_widget.dart';
import 'package:healing_apps/apps/views/pages/On%20Boarding/widget/onboarding_page_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'data/onboarding_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  int currentIndex = 0;

  void _nextPage() {
    if (currentIndex < onboardingItems.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prevPage() {
    if (currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.height * 0.02; // padding dinamis
    final topSafe = MediaQuery.of(
      context,
    ).padding.top; // tinggi notch/status bar

    return Scaffold(
      body: Stack(
        children: [
          /// --- Halaman Onboarding ---
          Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: onboardingItems.length,
                  onPageChanged: (index) {
                    setState(() => currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    final item = onboardingItems[index];
                    return OnboardingPageWidget(item: item);
                  },
                ),
              ),

              /// --- Page Indicator ---
              SmoothPageIndicator(
                controller: _controller,
                count: onboardingItems.length,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Color(0xFF0059B8),
                  dotColor: Color(0xFF719CD8),
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
              SizedBox(height: padding),

              /// --- Tombol bawah ---
              Padding(
                padding: EdgeInsets.all(padding),
                child: _buildBottomButtons(),
              ),
              SizedBox(height: padding),
            ],
          ),

          /// --- Tombol back khusus page 2 ---
          if (currentIndex == 1)
            Positioned(
              top: topSafe + 8, // biar gak ketiban notch
              left: 16,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: currentIndex == 1 ? 1.0 : 0.0,
                child: BackCircleButtonWidget(
                  onPressed: _prevPage,
                  iconColor: Colors.black,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    if (currentIndex == 0) {
      return Row(
        children: [
          Expanded(
            child: ButtonWidget(
              text: "Login",
              isPrimary: false,
              onPressed: () {},
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ButtonWidget(
              text: "Get Started",
              isPrimary: true,
              onPressed: _nextPage,
            ),
          ),
        ],
      );
    } else if (currentIndex == onboardingItems.length - 1) {
      return ButtonWidget(text: "Register", isPrimary: true, onPressed: () {});
    } else {
      return ButtonWidget(text: "Next", isPrimary: true, onPressed: _nextPage);
    }
  }
}
