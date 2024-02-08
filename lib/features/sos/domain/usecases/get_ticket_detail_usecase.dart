import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/sos_repository.dart';

@lazySingleton
class GetTicketDetail implements UseCase<Ticket, int> {
  final SOSRepository _sosRepository;

  GetTicketDetail(this._sosRepository);

  @override
  Future<Either<Failure, Ticket>> call(int params) async {
    return await _sosRepository.getTicketDetail(id: params);
  }
}
