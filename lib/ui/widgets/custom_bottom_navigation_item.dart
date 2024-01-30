import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final int selectedPage;
  final void Function(int) onDestinationSelected;

  const CustomBottomNavigationItem({
    super.key,
    required this.selectedPage,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 60,
      selectedIndex: 0,
      elevation: 0,
      destinations: [
        NavigationDestination(
          icon: ImageIcon(
            const AssetImage(
              "assets/icon_home.png",
            ),
            color: kGreyColor,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: ImageIcon(
            const AssetImage(
              "assets/icon_explore.png",
            ),
            color: kGreyColor,
          ),
          label: 'Explore',
        ),
        NavigationDestination(
          icon: ImageIcon(
            const AssetImage(
              "assets/icon_favorite.png",
            ),
            color: kGreyColor,
          ),
          label: 'Favorite',
        ),
        NavigationDestination(
          icon: ImageIcon(
            const AssetImage(
              "assets/icon_community.png",
            ),
            color: kGreyColor,
          ),
          label: 'Community',
        ),
        NavigationDestination(
          icon: ImageIcon(
            const AssetImage(
              "assets/icon_account.png",
            ),
            color: kGreyColor,
          ),
          label: 'Account',
        ),
      ],
    );
  }
}
