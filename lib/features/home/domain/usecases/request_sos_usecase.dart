import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/request_sos.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class RequestSOSUsecase implements UseCase<Ticket, RequestSOS> {
  final HomeRepository _homeRepository;

  RequestSOSUsecase(this._homeRepository);

  @override
  Future<Either<Failure, Ticket>> call(RequestSOS params) async {
    return await _homeRepository.requestSOS(data: params);
  }
}
