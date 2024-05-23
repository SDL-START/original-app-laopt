import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../repositories/register_repository.dart';

@lazySingleton
class UploadRegisterUsecase implements UseCase<ResponseData, File> {
  final RegisterRepository _registerRepository;

  UploadRegisterUsecase(this._registerRepository);

  @override
  Future<Either<Failure, ResponseData>> call(File params) async {
    return await _registerRepository.uploadFile(file: params);
  }
}
