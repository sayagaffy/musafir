import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/data/usecases/logout/logout.dart';
import 'package:musafir/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:musafir/presentation/providers/router/router_provider.dart';
import 'package:musafir/presentation/providers/user_data/user_data_provider.dart';
import 'package:musafir/presentation/widgets/custom_button.dart';
import 'package:musafir/shared/build_context_extensions.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainpageState();
}

class _MainpageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (previous != null && next is AsyncData && next.value == null) {
        ref.read(routerProvider).goNamed('login');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Main  Page'),
      ),
      body: Column(
        children: [
          Text(ref.watch(userDataProvider).when(
              data: (data) => data.toString(),
              error: (error, stackTrace) => '',
              loading: () => 'Loading')),
          CustomButton(
              title: 'Logout',
              onPressed: () {
                ref.read(userDataProvider.notifier).logout();
              })
        ],
      ),
    );
  }
}
