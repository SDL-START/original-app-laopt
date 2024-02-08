import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/user.dart';
import '../repositories/setting_repository.dart';

@lazySingleton
class UpdateProfileUsecase implements UseCase<User, User> {
  final SettingsRepository _settingsRepository;

  UpdateProfileUsecase(this._settingsRepository);

  @override
  Future<Either<Failure, User>> call(User params) async {
    return await _settingsRepository.updateProfile(data: params);
  }
}
