import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/presentation/providers/router/router_provider.dart';
import 'package:musafir/presentation/providers/user_data/user_data_provider.dart';
import 'package:musafir/presentation/widgets/custom_button.dart';
import 'package:musafir/presentation/widgets/musafir_text_field.dart';
import 'package:musafir/shared/build_context_extensions.dart';
import 'package:musafir/shared/methods.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed('main');
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Silahkan Isi Data Diri Kamu',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                verticalSpace(8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Awali petualangan kuliner di seluruh dunia.',
                  ),
                ),
                verticalSpace(15),
                MusafirTextField(
                    labelText: 'Email', controller: emailController),
                verticalSpace(15),
                MusafirTextField(
                    labelText: 'First Name', controller: firstNameController),
                verticalSpace(15),
                MusafirTextField(
                    labelText: 'Last Name', controller: lastNameController),
                verticalSpace(15),
                MusafirTextField(
                    labelText: 'No Handhphone',
                    controller: phoneNumberController),
                verticalSpace(15),
                MusafirTextField(
                  labelText: 'Kata Sandi',
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpace(15),
                MusafirTextField(
                    labelText: 'Konfirmasi Kata Sandi',
                    controller: retypePasswordController),
                verticalSpace(15),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: CustomButton(
                            title: 'Register',
                            onPressed: () {
                              if (passwordController.text ==
                                  retypePasswordController.text) {
                                ref.read(userDataProvider.notifier).register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text);
                              } else {
                                context.showSnackBar(
                                    'Please retype your password with the same value ');
                              }
                            },
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        ),
                  _ => const Center(
                      child: CircularProgressIndicator(),
                    )
                },
                verticalSpace(15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Sudah punya Akun? '),
                    TextButton(
                      onPressed: () {
                        ref.read(routerProvider).goNamed('login');
                      },
                      child: const Text('Login disini',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
