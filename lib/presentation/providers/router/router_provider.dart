import 'package:go_router/go_router.dart';
import 'package:musafir/presentation/pages/login_page/login_page.dart';
import 'package:musafir/presentation/pages/main_page.dart';
import 'package:musafir/presentation/pages/profile_page/profile_page.dart';
import 'package:musafir/presentation/pages/register_page/register_page.dart';
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
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/profile',
        name: 'profile',
        builder: (context, state) => const ProfilePage(),
      ),
    ], initialLocation: '/login', debugLogDiagnostics: false);
