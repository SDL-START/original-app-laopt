import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/user.dart';
import '../repositories/setting_repository.dart';
@lazySingleton
class GetUserInfoUsecase implements UseCase<User?,NoParams>{
  final SettingsRepository settingsRepository;
  GetUserInfoUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) async{
    return await settingsRepository.getUserInfo();
  }

}