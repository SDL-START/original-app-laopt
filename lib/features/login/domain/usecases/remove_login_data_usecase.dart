import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class RemoveLoginDataUsecase implements UseCase<bool,NoParams>{
  final AuthRepository _authRepository;

  RemoveLoginDataUsecase(this._authRepository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async{
    return await _authRepository.removeLoginData();
  }
  


}