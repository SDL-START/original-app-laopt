import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/ticket.dart';

import '../../../../core/usecases/usecase_sync.dart';
import '../repositories/support_repository.dart';

@lazySingleton
class GetTicketStreamUsecase
    implements
        SynchronousUseCase<Stream<List<Ticket>>,
            StreamController<List<Ticket>>> {
  final SupportRepository _repository;

  GetTicketStreamUsecase(this._repository);
  @override
  Stream<List<Ticket>> call(StreamController<List<Ticket>> params) {
    return _repository.getTicketStream(params);
  }
}
