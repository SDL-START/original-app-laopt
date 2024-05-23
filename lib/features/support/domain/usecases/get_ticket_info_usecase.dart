import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/support_repository.dart';

@lazySingleton
class GetTicketInfoUsecase implements UseCase<Ticket,int?>{
  final SupportRepository _repository;

  GetTicketInfoUsecase(this._repository);

  @override
  Future<Either<Failure, Ticket>> call(int? params)async {
    return await _repository.getTicketInfo(ticketId: params);
  }

}