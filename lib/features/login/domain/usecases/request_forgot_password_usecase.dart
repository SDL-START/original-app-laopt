import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class RequestForgotPasswordUsecase implements UseCase<User?,Map<String,dynamic>>{
  final AuthRepository authRepository;

  RequestForgotPasswordUsecase(this.authRepository);

  @override
  Future<Either<Failure, User?>> call(Map<String,dynamic> params)async {
    return await authRepository.forgotPassword(data: params);
  }
}