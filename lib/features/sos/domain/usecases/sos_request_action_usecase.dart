import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/sos_repository.dart';

@lazySingleton
class SOSRequestActionUsecase implements UseCase<dynamic, SOSRequestActionParams> {
  final SOSRepository _sosRepository;

  SOSRequestActionUsecase(this._sosRepository);

  @override
  Future<Either<Failure, dynamic>> call(SOSRequestActionParams params) async {
    return await _sosRepository.sosRequestActon(action: params.action,data: params.data);
  }
}

class SOSRequestActionParams {
  final String action;
  final Map<String,dynamic> data;

  SOSRequestActionParams(this.action, this.data);
}