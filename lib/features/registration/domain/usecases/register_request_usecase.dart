import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/register_data.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/user.dart';
import '../repositories/register_repository.dart';

@lazySingleton
class RegisterRequestUescase implements UseCase<User, RegisterData> {
  final RegisterRepository _registerRepository;

  RegisterRequestUescase(this._registerRepository);

  @override
  Future<Either<Failure, User>> call(RegisterData params) async {
    return await _registerRepository.registerRequest(data: params);
  }
}
