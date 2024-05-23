import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/scan_certificate.dart';
import 'package:insuranceapp/core/error/failures.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/certificate_repository.dart';
import '../datasources/certificate_remote_datasource.dart';

@LazySingleton(as: CertificateRepository)
class CertificateRepositoryImpl implements CertificateRepository {
  final CertificateDatasource _certificateDatasource;

  CertificateRepositoryImpl(this._certificateDatasource);
  @override
  Future<Either<Failure, ScanCertificate>> getCertificateScan(
      {required String code}) async {
    try {
      final res = await _certificateDatasource.getCertificateScan(code: code);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }
}
