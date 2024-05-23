import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/claim_log.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetClaimLogUsecase implements UseCase<List<ClaimLog>, GetClaimLogParams> {
  final HomeRepository homeRepository;

  GetClaimLogUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<ClaimLog>>> call(GetClaimLogParams params) async {
    return await homeRepository.getClaimLog(id: params.id);
  }
}

class GetClaimLogParams {
  final int id;

  GetClaimLogParams({required this.id});
}
