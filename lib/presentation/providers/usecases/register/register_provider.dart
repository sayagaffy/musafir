import 'package:musafir/data/usecases/register/register.dart';
import 'package:musafir/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:musafir/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_provider.g.dart';

@riverpod
Register register(RegisterRef ref) => Register(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
