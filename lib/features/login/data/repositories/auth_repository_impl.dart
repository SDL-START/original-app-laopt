import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/models/languages.dart';
import 'package:insuranceapp/core/models/login.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/login/data/datasources/auth_local_datasource.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';
import 'package:insuranceapp/features/login/domain/repositories/auth_repository.dart';

import '../datasources/auth_remote_datasource.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDatasource authLocalDatasource;
  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.authLocalDatasource,
  });

  @override
  Future<Either<Failure, List<Languages>>> getLanguage() async {
    try {
      final results = await authRemoteDataSource.getLanguage();
      return Right(results);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, User>> login({required Login loginData}) async {
    try {
      final result = await authRemoteDataSource.login(loginData: loginData);
      return Right(result);
    } on ServerException catch (er) {
      return Left(CacheFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, User?>> getLogin() async {
    try {
      final result = await authLocalDatasource.getLogin();
      return Right(result);
    } on CacheException catch (error) {
      return Left(CacheFailure(error.msg));
    }
  }

  @override
  Future<Either<Failure, List<Hospital>>> getHospital() async {
    try {
      final res = await authRemoteDataSource.getHospital();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, bool>> getInitialPlatform() async {
    try {
      final res = await authRemoteDataSource.getInitalPlatform();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, String?>> getFirebaseToken() async {
    try {
      final res = await authRemoteDataSource.getFirebaseToken();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, User?>> forgotPassword(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await authRemoteDataSource.forgotPassword(data: data);
      return Right(res);
    } on DioError catch (er) {
      return Left(ServerFailure(er.response?.data['message']));
    }
  }

  @override
  Future<Either<Failure, dynamic>> resetPassword(
      {required Map<String, dynamic> data}) async {
    try {
      final res = await authRemoteDataSource.resetPassword(data: data);
      return Right(res);
    } on DioError catch (er) {
      return Left(ServerFailure(er.response?.data['message']));
    }
  }

  @override
  LoginData getLoginData()  {
    try {
      return  authLocalDatasource.getLoginData();
    } on CacheException catch (e) {
      throw CacheFailure(e.msg);
    }
  }

  @override
  Future<Either<Failure,bool>> saveLoginData({required LoginData data}) async {
    try {
      return Right(await authLocalDatasource.saveLoginData(data: data));
    } on CacheException catch (e) {
      throw Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, bool>> removeLoginData() async {
    try {
      return Right(await authLocalDatasource.removeLoginData());
    } on CacheException catch (e) {
      throw Left(CacheFailure(e.msg));
    }
  }
}
