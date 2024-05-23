import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/insurance.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/buy_insurance_repository.dart';

@lazySingleton
class GetInsuranceTypeUsecase implements UseCase<List<Insurance>, NoParams> {
  final BuyInsuranceRepository _buyInsuranceRepository;

  GetInsuranceTypeUsecase(this._buyInsuranceRepository);
  @override
  Future<Either<Failure, List<Insurance>>> call(NoParams params) async {
    return await _buyInsuranceRepository.getInsuranceType();
  }
}
