import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/response_dropdown.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/home_repository.dart';

@lazySingleton
class GetClaimTypeUsecase implements UseCase<List<ResponseDropdown>,NoParams>{
  final HomeRepository homeRepository;

  GetClaimTypeUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<ResponseDropdown>>> call(NoParams params) async{
    return await homeRepository.getClaimType();
  }

}