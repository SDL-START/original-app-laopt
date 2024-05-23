import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/setting_repository.dart';

@lazySingleton
class GetProvinceUsecase implements UseCase<List<Province>, NoParams> {
  final SettingsRepository _settingsRepository;

  GetProvinceUsecase(this._settingsRepository);

  @override
  Future<Either<Failure, List<Province>>> call(NoParams params) async {
    return await _settingsRepository.getProvinces();
  }
}
