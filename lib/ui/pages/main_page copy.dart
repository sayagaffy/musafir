import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/account_page.dart';
import 'package:musafir/ui/pages/community_page.dart';
import 'package:musafir/ui/pages/explore_pages.dart';
import 'package:musafir/ui/pages/favorite_page.dart';
import 'package:musafir/ui/pages/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int myCurrentIndex = 0;

  List pages = const [
    HomePage(),
    ExplorePage(),
    FavoritePage(),
    CommunityPage(),
    AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
      ),
      child: Scaffold(
        bottomNavigationBar: AnimatedScale(
          duration: const Duration(milliseconds: 400),
          scale: 1,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kBlackColor,
                )
              ],
            ),
            child: BottomNavigationBar(
              backgroundColor: kBackgroundColor,
              currentIndex: myCurrentIndex,
              unselectedItemColor: kGreyColor,
              selectedItemColor: kPrimaryColor,
              selectedLabelStyle: const TextStyle(fontSize: 11),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                setState(() {
                  myCurrentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icon_home.png",
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icon_explore.png",
                    ),
                  ),
                  label: 'Explore',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icon_favorite.png",
                    ),
                  ),
                  label: 'Favorite',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icon_community.png",
                    ),
                  ),
                  label: 'Community',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(
                      "assets/icon_account.png",
                    ),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
        body: pages[myCurrentIndex],
      ),
    );
  }
}
