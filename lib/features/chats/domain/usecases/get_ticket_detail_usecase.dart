import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/ticket_log.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/chats/domain/repositories/chat_repository.dart';

@lazySingleton
class GetTicketDetailUsecase
    implements UseCase<TicketLog, GetTicketDetailParams> {
  final ChatRepository _chatRepository;

  GetTicketDetailUsecase(this._chatRepository);

  @override
  Future<Either<Failure, TicketLog>> call(GetTicketDetailParams params) async {
    return await _chatRepository.getTicketDetail(
        id: 0, status: params.ticket?.status ?? '');
  }
}

class GetTicketDetailParams {
  final Ticket? ticket;

  GetTicketDetailParams({this.ticket});
}
