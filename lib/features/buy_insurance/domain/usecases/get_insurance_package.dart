import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/insurance_package.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/buy_insurance_repository.dart';

@lazySingleton
class GetInsurancePackageUsecase
    implements UseCase<List<InsurancePackage>, int> {
  final BuyInsuranceRepository _buyInsuranceRepository;

  GetInsurancePackageUsecase(this._buyInsuranceRepository);
  @override
  Future<Either<Failure, List<InsurancePackage>>> call(
      int params) async {
    return await _buyInsuranceRepository.getInsurancePackage(id: params);
  }
}
