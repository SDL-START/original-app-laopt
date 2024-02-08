import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetSOSProcessingUsecase implements UseCase<List<SOSLogs>,NoParams>{
  final HomeRepository _homeRepository;

  GetSOSProcessingUsecase(this._homeRepository);

  @override
  Future<Either<Failure, List<SOSLogs>>> call(NoParams params) async{
    return await _homeRepository.getSOSProcessing();
  }
  
}