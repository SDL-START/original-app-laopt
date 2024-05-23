import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';
import 'package:insuranceapp/core/models/certificate_response.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/models/claim_log.dart';
import 'package:insuranceapp/core/models/menu.dart';
import 'package:insuranceapp/core/models/pt_image.dart';
import 'package:insuranceapp/core/models/request_sos.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/response_dropdown.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/features/home/data/datasources/home_remote_datasourec.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

import '../../../../core/models/claim_request.dart';
import '../../../../core/models/response_qr.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;

  HomeRepositoryImpl(this.homeRemoteDatasource);
  @override
  Future<Either<Failure, List<PTImage>>> getSlideImage() async {
    try {
      final res = await homeRemoteDatasource.getSlideImage();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Menu>>> getMenu() async {
    try {
      final res = await homeRemoteDatasource.getMenu();
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> uploadFile({required File file}) async {
    try {
      final res = await homeRemoteDatasource.uploadFile(file: file);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, CertificateResponse>> createCertificate(
      {required Certificate body}) async {
    try {
      final res = await homeRemoteDatasource.createCertificate(body: body);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getGenerateQR(
      {required String id, required String amount}) async {
    try {
      final res =
          await homeRemoteDatasource.getGenerateQR(id: id, amount: amount);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Certificate>>> getMyInsurance() async {
    try {
      final res = await homeRemoteDatasource.getMyInsurance();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Claim>>> getClaim() async {
    try {
      final res = await homeRemoteDatasource.getClaim();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<ClaimLog>>> getClaimLog({required int id}) async {
    try {
      final res = await homeRemoteDatasource.getClaimLog(id: id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<ResponseDropdown>>> getClaimType() async {
    try {
      final res = await homeRemoteDatasource.getClaimType();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, String>> payCredit({Certificate? certificate}) async {
    try {
      final res =
          await homeRemoteDatasource.payCredit(certificate: certificate);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Responseqr>> payBCEL(
      {required String id, String? amount}) async {
    try {
      final res = await homeRemoteDatasource.payBCEL(id: id, amount: amount);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<Certificate>>> getPaidInsurance() async {
    try {
      final res = await homeRemoteDatasource.getPaidInsurance();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Ticket>> requestSOS({required RequestSOS data}) async {
    try {
      final res = await homeRemoteDatasource.requestSOS(data: data);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, dynamic>> cliamRequest(
      {required ClaimRequest data}) async {
    try {
      final res = await homeRemoteDatasource.claimRequest(data: data);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<SOSLogs>>> getSOSProcessing() async {
    try {
      final res = await homeRemoteDatasource.getSOSProcessing();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<CertificateMember>>> getCertificateMember(
      {int? id}) async {
    try {
      final res = await homeRemoteDatasource.getCertificateMember(id: id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }
}
