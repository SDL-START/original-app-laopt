import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class GetFirebaseTokenusecase implements UseCase<String?, NoParams> {
  final AuthRepository _authRepository;

  GetFirebaseTokenusecase(this._authRepository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await _authRepository.getFirebaseToken();
  }
}
