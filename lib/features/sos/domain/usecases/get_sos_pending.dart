import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/sos_repository.dart';

@lazySingleton
class GetSOSPendingUsecase implements UseCase<List<Ticket>, NoParams> {
  final SOSRepository _sosRepository;

  GetSOSPendingUsecase(this._sosRepository);

  @override
  Future<Either<Failure, List<Ticket>>> call(NoParams params) async {
    return await _sosRepository.getSOSPending();
  }
}
