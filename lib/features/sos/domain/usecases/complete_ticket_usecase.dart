import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/ticket_action.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/sos_repository.dart';

@lazySingleton
class CompleteTicketUsecase implements UseCase<Ticket, TicketAction> {
  final SOSRepository _sosRepository;
  CompleteTicketUsecase(this._sosRepository);

  @override
  Future<Either<Failure, Ticket>> call(TicketAction params) async {
    return await _sosRepository.completeTicket(action: params);
  }
}
