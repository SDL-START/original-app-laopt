import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/claim_request.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class ClaimRequestUsecase implements UseCase<dynamic, ClaimRequest> {
  final HomeRepository _homeRepository;

  ClaimRequestUsecase(this._homeRepository);
  @override
  Future<Either<Failure, dynamic>> call(ClaimRequest params) async {
    return _homeRepository.cliamRequest(data: params);
  }
}
