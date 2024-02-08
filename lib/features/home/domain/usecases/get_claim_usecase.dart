import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetClaimUsecase implements UseCase<List<Claim>, NoParams> {
  final HomeRepository homeRepository;
  GetClaimUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<Claim>>> call(NoParams params) async {
    return await homeRepository.getClaim();
  }
}
