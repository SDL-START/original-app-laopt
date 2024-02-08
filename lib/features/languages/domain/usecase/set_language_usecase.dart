import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/lang_repository.dart';

@lazySingleton
class SetLanguageUsecase implements UseCase<bool,String>{
  final LangRepository _langRepository;

  SetLanguageUsecase(this._langRepository);

  @override
  Future<Either<Failure, bool>> call(String params)async {
    return await _langRepository.setLanguageCode(code: params);
  }

}