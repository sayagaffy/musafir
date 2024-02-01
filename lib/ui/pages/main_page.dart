import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/pages/account_page.dart';
import 'package:musafir/ui/pages/community_page.dart';
// import 'package:musafir/ui/pages/explore_pages.dart';
import 'package:musafir/ui/pages/favorite_page.dart';
import 'package:musafir/ui/pages/home_page.dart';
import 'package:musafir/ui/pages/map_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

List<Widget> _buildScreens() {
  return [
    const HomePage(),
    // const ExplorePage(),
    const MapPage(),
    const FavoritePage(),
    const CommunityPage(),
    const AccountPage()
  ];
}

List<PersistentBottomNavBarItem> _navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const ImageIcon(
        AssetImage(
          "assets/icon_home.png",
        ),
      ),
      title: "Home",
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: kGreyColor,
    ),
    PersistentBottomNavBarItem(
      icon: const ImageIcon(
        AssetImage(
          "assets/icon_explore.png",
        ),
      ),
      title: "Explore",
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: kGreyColor,
    ),
    PersistentBottomNavBarItem(
      icon: const ImageIcon(
        AssetImage(
          "assets/icon_favorite.png",
        ),
      ),
      title: "Favorite",
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: kGreyColor,
    ),
    PersistentBottomNavBarItem(
      icon: const ImageIcon(
        AssetImage(
          "assets/icon_community.png",
        ),
      ),
      title: "Community",
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: kGreyColor,
    ),
    PersistentBottomNavBarItem(
      icon: const ImageIcon(
        AssetImage(
          "assets/icon_account.png",
        ),
      ),
      title: "Account",
      activeColorPrimary: kPrimaryColor,
      inactiveColorPrimary: kGreyColor,
    ),
  ];
}

PersistentTabController? _controller = PersistentTabController(initialIndex: 0);

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PersistentTabView(
            context,
            controller: _controller,
            screens: _buildScreens(),
            items: _navBarsItems(),
            confineInSafeArea: true,
            backgroundColor: kBackgroundColor, // Default is Colors.white.
            handleAndroidBackButtonPress: true, // Default is true.
            resizeToAvoidBottomInset:
                true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
            stateManagement: true, // Default is true.
            hideNavigationBarWhenKeyboardShows:
                true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(10.0),
              colorBehindNavBar: Colors.white,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            // screenTransitionAnimation:const  ScreenTransitionAnimation(
            //   // Screen transition animation on change of selected tab.
            //   animateTabTransition: true,
            //   curve: Curves.ease,
            //   duration: Duration(milliseconds: 200),
            // ),
            navBarStyle: NavBarStyle
                .style6, // Choose the nav bar style with this property.
          ),
        ],
      ),
    );
  }
}
