import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/hospital_repository.dart';

@lazySingleton
class GetHospitalService implements UseCase<List<Hospital>, NoParams> {
  final HospitalRepository _hospitalRepository;

  GetHospitalService(this._hospitalRepository);

  @override
  Future<Either<Failure, List<Hospital>>> call(NoParams params) async {
    return await _hospitalRepository.getHospitalService();
  }
}
