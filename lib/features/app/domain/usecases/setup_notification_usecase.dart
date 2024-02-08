import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/app_repository.dart';

@lazySingleton
class SetupNotificationUsecase implements UseCase<void, NoParams> {
  final AppRepository _appRepository;
  SetupNotificationUsecase(this._appRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _appRepository.setupFlutterNotifications();
  }
}
