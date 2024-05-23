import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/confirm_otp.dart';
import 'package:insuranceapp/core/models/register.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/models/register_data.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/models/response_data.dart';
import '../../domain/repositories/register_repository.dart';
import '../datasources/register_remote_datasource.dart';

@LazySingleton(as:RegisterRepository )
class RegisterRepositoryImpl implements RegisterRepository {
  final RegisterRemoteDatasourec _registerRemoteDatasourec;

  RegisterRepositoryImpl(this._registerRemoteDatasourec);
  @override
  Future<Either<Failure, User>> registerRequest(
      {required RegisterData data}) async {
    try {
      final res = await _registerRemoteDatasourec.registerRequest(data: data);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> confirmOTP({required ConfirmOTP data}) async{
     try {
      final res = await _registerRemoteDatasourec.confirmOTP(data: data);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> uploadFile({required File file})async {
    try {
      final res = await _registerRemoteDatasourec.uploadFile(file: file);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, dynamic>> register({required Register data})async {
    try {
      final res = await _registerRemoteDatasourec.register(data: data);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }
}
