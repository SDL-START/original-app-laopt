import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/register.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/register_repository.dart';

@lazySingleton
class RegisterUsecase implements UseCase<dynamic, Register> {
  final RegisterRepository _registerRepository;

  RegisterUsecase(this._registerRepository);

  @override
  Future<Either<Failure, dynamic>> call(Register params) async {
    return await _registerRepository.register(data: params);
  }
}
