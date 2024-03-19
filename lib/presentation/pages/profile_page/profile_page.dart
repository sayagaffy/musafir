import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/presentation/pages/profile_page/methods/profile_item.dart';
import 'package:musafir/presentation/pages/profile_page/methods/user_info.dart';
import 'package:musafir/presentation/providers/user_data/user_data_provider.dart';
import 'package:musafir/shared/methods.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              ...userInfo(ref),
              const Divider(),
              verticalSpace(20),
              profileItem('Update Profile'),
              profileItem('Change Password'),
              profileItem('Change Language'),
              const Divider(),
              profileItem('FAQ'),
              profileItem('Contact Us'),
              profileItem('Privacy Policy'),
              ElevatedButton(
                  onPressed: () {
                    ref.read(userDataProvider.notifier).logout();
                  },
                  child: const Text('Logout'))
            ],
          ),
        )
      ],
    );
  }
}
