import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/confirm_otp.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/register_repository.dart';

@lazySingleton
class ConfirmOTPUsecase implements UseCase<ResponseData,ConfirmOTP>{
  final RegisterRepository _registerRepository;

  ConfirmOTPUsecase(this._registerRepository);
  @override
  Future<Either<Failure, ResponseData>> call(ConfirmOTP params) async{
    return await _registerRepository.confirmOTP(data: params);
  }

}