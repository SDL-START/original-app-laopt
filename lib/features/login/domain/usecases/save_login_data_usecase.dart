import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class SaveLoginDataUsecase implements UseCase<bool, LoginData> {
  final AuthRepository _authRepository;

  SaveLoginDataUsecase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(LoginData params)async {
    return await _authRepository.saveLoginData(data: params);
  }
  

}
