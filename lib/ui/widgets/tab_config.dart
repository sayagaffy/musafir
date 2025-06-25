import 'package:flutter/material.dart';
import 'package:musafir/ui/pages/home/home_page.dart';
import 'package:musafir/ui/pages/explore/explore_pages.dart';
import 'package:musafir/ui/pages/account/account_page.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:musafir/shared/theme.dart';

List<PersistentTabConfig> buildTabConfigs() {
  return [
    PersistentTabConfig(
      screen: const HomePage(),
      item: ItemConfig(
        icon: const ImageIcon(
          AssetImage("assets/icon_home.png"),
        ),
        title: "Home",
        activeForegroundColor: kBlueColor,
        inactiveForegroundColor: kGreyColor,
      ),
    ),
    PersistentTabConfig(
      screen: const ExplorePage(),
      item: ItemConfig(
        icon: const ImageIcon(
          AssetImage("assets/icon_explore.png"),
        ),
        title: "Itinerary",
      ),
    ),
    PersistentTabConfig(
      screen: const AccountPage(),
      item: ItemConfig(
        icon: const ImageIcon(
          AssetImage("assets/icon_account.png"),
        ),
        title: "Account",
      ),
    ),
  ];
}
