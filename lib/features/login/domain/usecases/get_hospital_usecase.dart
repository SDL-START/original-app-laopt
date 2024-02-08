import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/login/domain/repositories/auth_repository.dart';

@lazySingleton
class GetHospitalUsecase implements UseCase<List<Hospital>, NoParams> {
  final AuthRepository authRepository;

  GetHospitalUsecase(this.authRepository);

  @override
  Future<Either<Failure, List<Hospital>>> call(NoParams params) async {
    return await authRepository.getHospital();
  }
}
