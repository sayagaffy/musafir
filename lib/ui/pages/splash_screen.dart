import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musafir/ui/pages/splash_widget.dart';
import '../../shared/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> _splashPages = [
    {
      'title': 'Musafir: Teman Perjalanan Anda',
      'description':
          'Jelajahi dunia dengan mudah—cari restoran halal dan ruang shalat terdekat, di mana pun Anda berada.',
      'image': 'assets/icon_musafir.png'
    },
    {
      'title': 'Halal itu Mudah, Cari dengan Cepat!',
      'description':
          'Dapatkan rekomendasi restoran halal terverifikasi dengan menu dan jarak yang sesuai kebutuhan Anda.',
      'image': 'assets/image_map.png'
    },
    {
      'title': 'Perjalanan Terencana, Ibadah Tetap Lancar',
      'description':
          'Buat itinerary harian dengan menggabungkan destinasi kuliner halal dan tempat shalat terdekat.',
      'image': 'assets/icon_community.png'
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _splashPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return _buildPageContent(_splashPages[index]);
              },
            ),
          ),
          _buildPageIndicator(),
          _buildNextButton(),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPageContent(Map<String, String> page) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            page['image']!,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 30),
          Text(
            page['title']!,
            style: blackTextStyle.copyWith(
              fontSize: 24,
              fontWeight: bold,
              color: kBlueColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            page['description']!,
            style: blackTextStyle.copyWith(
              fontSize: 16,
              color: kBlueColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _splashPages.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index
                ? kBlueColor
                : kBlueColor.withOpacity(0.4),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: kBlueColor,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          if (_currentPage < _splashPages.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            Get.offAll(() => const SplashPage());
          }
        },
        child: Text(
          _currentPage == _splashPages.length - 1 ? 'Mulai' : 'Lanjut',
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: bold,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
