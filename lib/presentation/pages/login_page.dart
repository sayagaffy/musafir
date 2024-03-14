import 'package:flutter/material.dart';
import 'package:musafir/presentation/providers/router/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/presentation/providers/user_data/user_data_provider.dart';
import 'package:musafir/presentation/widgets/custom_button.dart';
import 'package:musafir/presentation/widgets/musafir_text_field.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        } else if (next is AsyncError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.error.toString())));
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          MusafirTextField(
            labelText: 'Email',
            controller: emailController,
          ),
          CustomButton(
              title: 'Login',
              onPressed: () {
                ref
                    .read(userDataProvider.notifier)
                    .login(email: "kitacoba@bisa.com", password: "123456");
              })
        ],
      ),
    );
  }
}
