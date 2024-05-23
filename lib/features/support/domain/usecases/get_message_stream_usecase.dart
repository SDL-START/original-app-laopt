import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/sos_message.dart';

import '../../../../core/usecases/usecase_sync.dart';
import '../repositories/support_repository.dart';

@lazySingleton
class GetMessageStreamUsecase
    implements SynchronousUseCase<Stream<List<SOSMessage>>, GetMessageParams> {
  final SupportRepository _repository;

  GetMessageStreamUsecase(this._repository);
  @override
  Stream<List<SOSMessage>> call(GetMessageParams params) {
    return _repository.getMessageStream(params.controller, params.ticketId);
  }
}

class GetMessageParams {
  final StreamController<List<SOSMessage>> controller;
  final int? ticketId;

  GetMessageParams(this.controller, this.ticketId);
}
