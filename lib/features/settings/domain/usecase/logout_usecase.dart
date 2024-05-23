import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class LogoutUsecase implements UseCase <bool,NoParams>{
  final SettingsRepository settingsRepository;
  LogoutUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params)async {
    return await settingsRepository.logOut();
  }
}