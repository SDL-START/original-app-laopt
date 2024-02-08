import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/scan_certificate.dart';

abstract class CertificateRepository {
  Future<Either<Failure, ScanCertificate>> getCertificateScan(
      {required String code});
}
