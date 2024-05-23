import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/settings/domain/repositories/setting_repository.dart';

@lazySingleton
class GetLanguaseUsecase implements UseCase<String?,NoParams>{
  final SettingsRepository settingsRepository;

  GetLanguaseUsecase(this.settingsRepository);

  @override
  Future<Either<Failure, String?>> call(NoParams params)async {
    return await settingsRepository.getLanguage();
  }

}