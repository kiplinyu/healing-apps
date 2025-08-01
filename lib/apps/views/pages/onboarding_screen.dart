import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:healing_apps/apps/utils/constant/constants.dart';
import 'package:healing_apps/apps/views/widgets/wide_highlight_text.dart';
import 'package:healing_apps/apps/models/slide_mode.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../widgets/primary_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<SlideModel> slides = [
    SlideModel(
      imageUrl:
          'https://images.unsplash.com/photo-1501785888041-af3ef285b470?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'Life is short and the world is wide',
      subtitle:
          'At Friends tours and travel, we customize reliable and trustworthy educational tours to destinations all over the world.',
    ),
    SlideModel(
      imageUrl:
          'https://images.unsplash.com/photo-1655337169484-d9bf5a8c5b6f?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'It’s a big world out there go explore',
      subtitle:
          'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
    ),
    SlideModel(
      imageUrl:
          'https://images.unsplash.com/photo-1534142499731-a32a99935397?q=80&w=688&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      title: 'People don’t take trips, trips take people',
      subtitle:
          'To get the best of your adventure you just need to leave and go where you like. we are waiting for you',
    ),
  ];

  // Fungsi untuk mengekstrak kata yang di-highlight
  String _getHighlightedWord(String title) {
    if (title.contains('wide')) return 'wide';
    if (title.contains('explore')) return 'explore';
    if (title.contains('people')) return 'people';
    return '';
  }

  // Fungsi untuk mendapatkan teks sebelum kata yang di-highlight
  String _getBaseText(String title, String highlightedWord) {
    return title.replaceAll(highlightedWord, '').trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: slides.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                final slide = slides[index];
                final highlightedWord = _getHighlightedWord(slide.title);
                final baseText = _getBaseText(slide.title, highlightedWord);

                return Column(
                  children: [
                    // Gambar setengah layar dengan rounded bottom
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                      ),
                      child: Image.network(
                        slide.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Konten teks dengan highlight
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        spacing: 24,
                        children: [
                          // Judul dengan kata yang di-highlight
                          WideHighlightText(
                            textBefore: baseText,
                            highlightedText: highlightedWord,
                            textAfter: " ",
                            underlineSvgAssetPath:
                                "assets/images/Vector 2524.svg",
                          ),
                          const SizedBox(height: 8),
                          // Subtitle
                          Text(
                            slide.subtitle,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge
                                ?.copyWith(
                                  fontSize: 16,
                                  fontFamily: 'Gil',
                                  color: Colors.grey[600],
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Page indicator
          SmoothPageIndicator(
            controller: _pageController,
            count: slides.length,
            effect: const ExpandingDotsEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: AppColors.ascent,
              dotColor: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          // Tombol
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: PrimaryButton(
              text: _currentPage == slides.length - 1 ? 'Get Started' : 'Next',
              onPressed: () {
                if (_currentPage == slides.length - 1) {
                  // Notes: Register Page
                  context.push('/register');
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// Halaman tujuan setelah onboarding
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text('Welcome!')),
    );
  }
}
