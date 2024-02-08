import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/user.dart';
import '../repositories/auth_repository.dart';

@lazySingleton
class GetLoginUsecase implements UseCase<User?, NoParams> {
  final AuthRepository authRepository;

  GetLoginUsecase(this.authRepository);
  @override
  Future<Either<Failure, User?>> call(NoParams params) async {
    return await authRepository.getLogin();
  }
}
