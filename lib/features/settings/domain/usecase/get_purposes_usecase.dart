import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/purpose.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class GetPurposesUsecase implements UseCase<List<Purpose>, NoParams> {
  final SettingsRepository _settingsRepository;

  GetPurposesUsecase(this._settingsRepository);

  @override
  Future<Either<Failure, List<Purpose>>> call(NoParams params) async {
    return await _settingsRepository.getPurposes();
  }
}
