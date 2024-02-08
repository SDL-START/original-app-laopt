import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/languages.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/auth_repository.dart';

@lazySingleton
class GetLanguagesUsecase implements UseCase<List<Languages>,NoParams>{
  final AuthRepository authRepository;

  GetLanguagesUsecase(this.authRepository);
  @override
  Future<Either<Failure, List<Languages>>> call(NoParams params) async{
    return await authRepository.getLanguage();
  }
}