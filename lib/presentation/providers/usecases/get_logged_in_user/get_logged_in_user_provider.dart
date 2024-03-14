import 'package:musafir/data/usecases/get_logged_in_user/get_logged_in_user.dart';
import 'package:musafir/presentation/providers/repositories/authentication/authentication_provider.dart';
import 'package:musafir/presentation/providers/repositories/user_repository/user_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_logged_in_user_provider.g.dart';

@riverpod
GetLoggedInUser getLoggedInUser(GetLoggedInUserRef ref) => GetLoggedInUser(
    authentication: ref.watch(authenticationProvider),
    userRepository: ref.watch(userRepositoryProvider));
