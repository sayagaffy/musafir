import 'package:flutter/material.dart';
import 'package:musafir/presentation/providers/router/router_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/presentation/providers/user_data/user_data_provider.dart';
import 'package:musafir/presentation/widgets/custom_button.dart';
import 'package:musafir/presentation/widgets/musafir_text_field.dart';
import 'package:musafir/shared/build_context_extensions.dart';
import 'package:musafir/shared/methods.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                MusafirTextField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                verticalSpace(15),
                MusafirTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  obscureText: true,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Lupa kata sandi',
                    ),
                  ),
                ),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                              title: 'Masuk',
                              onPressed: () {
                                ref.read(userDataProvider.notifier).login(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(child: CircularProgressIndicator())
                },
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Belum Punya Akun? '),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('register');
                      },
                      child: const Text('Daftar'),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
