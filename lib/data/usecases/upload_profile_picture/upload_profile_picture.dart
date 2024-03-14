import 'package:musafir/data/entities/result.dart';
import 'package:musafir/data/entities/user.dart';
import 'package:musafir/data/repositories/user_repository.dart';
import 'package:musafir/data/usecases/usecase.dart';
import 'package:musafir/data/usecases/upload_profile_picture/upload_profile_picture_params.dart';

class UploadProfilePicture
    implements UseCase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => _userRepository
      .uploadProfilePicture(imageFile: params.imageFile, user: params.user);
}
