import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/change_password.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/models/purpose.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:insuranceapp/features/settings/data/datasources/settings_remote_datasource.dart';
import 'package:insuranceapp/features/settings/domain/repositories/setting_repository.dart';

import '../../../../core/models/response_data.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDatasource settingsLocalDatasource;
  final SettingsRemoteDatasourec settingsRemoteDatasourec;

  SettingsRepositoryImpl(
      this.settingsLocalDatasource, this.settingsRemoteDatasourec);
  @override
  Future<Either<Failure, String?>> getLanguage() async {
    try {
      final res = await settingsLocalDatasource.getLanguage();
      return Right(res);
    } on CacheException catch (error) {
      return Left(CacheFailure(error.msg));
    }
  }

  @override
  Future<Either<Failure, User?>> getUserInfo() async {
    try {
      final res = await settingsLocalDatasource.getUserInfo();
      return Right(res);
    } on CacheException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> changePassword(
      {required ChangePassword data,required String token}) async {
    try {
      final res = await settingsRemoteDatasourec.changePassword(data: data,token: token);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
  
  @override
  Future<Either<Failure, bool>> logOut()async {
    try {
      final res = await settingsLocalDatasource.logOut();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Purpose>>> getPurposes() async{
    try {
      final res = await settingsRemoteDatasourec.getPurposes();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Province>>> getProvinces() async{
    try {
      final res = await settingsRemoteDatasourec.getProvinces();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
  
  @override
  Future<Either<Failure, User>> updateProfile({required User data}) async{
    try {
      final res = await settingsRemoteDatasourec.updateProfile(data: data);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }
}
