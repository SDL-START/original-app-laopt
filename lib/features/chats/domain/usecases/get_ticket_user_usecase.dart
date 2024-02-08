import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/chats/domain/repositories/chat_repository.dart';

@lazySingleton
class GetTicketHistories implements UseCase<List<Ticket>, NoParams> {
  final ChatRepository _chatRepository;

  GetTicketHistories(this._chatRepository);

  @override
  Future<Either<Failure, List<Ticket>>> call(NoParams params) async {
    return await _chatRepository.getTicketHistories();
  }
}
