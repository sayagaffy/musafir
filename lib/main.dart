import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:musafir/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:musafir/presentation/providers/router/router_provider.dart';
import 'package:musafir/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MainApp()),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor,
            background: kBackgroundColor,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          textTheme: TextTheme(
              bodyMedium: GoogleFonts.poppins(color: kBlackColor),
              bodyLarge: GoogleFonts.poppins(color: kBlackColor),
              labelLarge: GoogleFonts.poppins(color: kBlackColor))),
      debugShowCheckedModeBanner: false,
      routeInformationParser: ref.watch(routerProvider).routeInformationParser,
      routeInformationProvider:
          ref.watch(routerProvider).routeInformationProvider,
      routerDelegate: ref.watch(routerProvider).routerDelegate,
    );
  }
}
