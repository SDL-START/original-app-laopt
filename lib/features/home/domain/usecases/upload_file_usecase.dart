import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class UploadFileUsecase implements UseCase<ResponseData, File> {
  final HomeRepository homeRepository;
  UploadFileUsecase(this.homeRepository);

  @override
  Future<Either<Failure, ResponseData>> call(File params) async {
    return await homeRepository.uploadFile(file: params);
  }
}

