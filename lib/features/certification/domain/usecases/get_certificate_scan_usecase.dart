import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/scan_certificate.dart';
import '../repositories/certificate_repository.dart';

@lazySingleton
class GetCertificateScan implements UseCase<ScanCertificate, String> {
  final CertificateRepository _certificateRepository;

  GetCertificateScan(this._certificateRepository);

  @override
  Future<Either<Failure, ScanCertificate>> call(String params) async {
    return await _certificateRepository.getCertificateScan(code: params);
  }
}
