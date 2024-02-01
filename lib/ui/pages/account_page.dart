import 'package:flutter/material.dart';
import 'package:musafir/shared/theme.dart';
import 'package:musafir/ui/widgets/account_widget.dart';
import 'package:musafir/ui/widgets/app_icon.dart';
import 'package:musafir/ui/widgets/big_text.dart';
import 'package:musafir/utils/dimendsions.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Center(
            child: BigText(
              text: 'Account Profile',
              size: 20,
              color: kBlackColor,
            ),
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(top: 10),
        child: const SingleChildScrollView(
          child: Column(
            children: [
              AppIcon(
                icon: Icons.person_2_rounded,
                size: 50,
                iconSize: 39,
                backgroundColor: Color.fromARGB(255, 14, 108, 195),
                iconColor: Color(0xFFFFFFFF),
              ),
              SizedBox(
                height: 50,
              ),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.person,
                  size: 35,
                  iconSize: 20,
                  iconColor: Color(0xFFFFFFFF),
                ),
                bigText: BigText(
                  text: 'Profile',
                  size: 15,
                ),
              ),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.phone,
                  size: 35,
                  iconSize: 20,
                  backgroundColor: Color(0xff0EC3AE),
                  iconColor: Color(0xFFFFFFFF),
                ),
                bigText: BigText(
                  text: 'Phone',
                  size: 15,
                ),
              ),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.email,
                  size: 35,
                  iconSize: 20,
                  backgroundColor: Color.fromARGB(255, 14, 108, 195),
                  iconColor: Color(0xFFFFFFFF),
                ),
                bigText: BigText(
                  text: 'Email',
                  size: 15,
                ),
              ),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.location_on,
                  size: 35,
                  iconSize: 20,
                  backgroundColor: Color.fromARGB(255, 68, 195, 14),
                  iconColor: Color(0xFFFFFFFF),
                ),
                bigText: BigText(
                  text: 'Address',
                  size: 15,
                ),
              ),
              AccountWidget(
                appIcon: AppIcon(
                  icon: Icons.email,
                  size: 35,
                  iconSize: 20,
                  backgroundColor: Color.fromARGB(255, 195, 14, 162),
                  iconColor: Color(0xFFFFFFFF),
                ),
                bigText: BigText(
                  text: 'Message',
                  size: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
