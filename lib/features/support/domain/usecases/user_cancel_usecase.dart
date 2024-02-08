import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/support_repository.dart';

@lazySingleton
class UserCancelUsecase implements UseCase<ResponseData,int>{
  final SupportRepository _repository;
  UserCancelUsecase(this._repository);

  @override
  Future<Either<Failure, ResponseData>> call(int params) async{
    return await _repository.userCancel(ticketId: params);
  }
}