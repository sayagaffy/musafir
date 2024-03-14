import 'package:go_router/go_router.dart';
import 'package:musafir/presentation/pages/login_page.dart';
import 'package:musafir/presentation/pages/main_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(routes: [
      GoRoute(
        path: '/main',
        name: 'main',
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginPage(),
      )
    ], initialLocation: '/login', debugLogDiagnostics: false);
