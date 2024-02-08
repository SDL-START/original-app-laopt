import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class ResetPasswordUsecase implements UseCase<dynamic,Map<String,dynamic>>{
  final AuthRepository authRepository;

  ResetPasswordUsecase(this.authRepository);

  @override
  Future<Either<Failure, dynamic>> call(Map<String, dynamic> params)async {
    return await authRepository.resetPassword(data: params);
  }
}