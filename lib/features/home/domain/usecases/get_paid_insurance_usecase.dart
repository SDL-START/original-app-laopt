import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetPaidInsuranceUsecase implements UseCase<List<Certificate>, NoParams> {
  final HomeRepository homeRepository;

  GetPaidInsuranceUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<Certificate>>> call(NoParams params) async {
    return await homeRepository.getPaidInsurance();
  }
}
