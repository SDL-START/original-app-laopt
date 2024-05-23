import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/send_message.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/support_repository.dart';

@lazySingleton
class SendMessageUsecase implements UseCase<dynamic, SendMessage> {
  final SupportRepository _repository;

  SendMessageUsecase(this._repository);
  @override
  Future<Either<Failure, dynamic>> call(SendMessage params) async {
    return await _repository.sendMessage(body: params);
  }
}
