import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/login.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/login/domain/repositories/auth_repository.dart';
@lazySingleton
class LoginUsecase implements UseCase<User, LoginParams> {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(LoginParams params) async {
    return await authRepository.login(loginData: params.loginData);
  }
}

class LoginParams extends Equatable {
  final Login loginData;
  const LoginParams({required this.loginData});

  @override
  List<Object?> get props => [loginData];
}
