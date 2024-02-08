import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/models/scan_certificate.dart';

abstract class CertificateDatasource {
  Future<ScanCertificate> getCertificateScan({required String code});
}

@LazySingleton(as: CertificateDatasource)
class CertificateDatasourceImpl implements CertificateDatasource {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;
  CertificateDatasourceImpl(this._networkCall, this._pref);
  @override
  Future<ScanCertificate> getCertificateScan({required String code}) async {
    try {
      final token = await _pref.getUserToken();
      final scanCertificate =
          await _networkCall.getCertificateScan(token ?? '', code);
      return scanCertificate;
    // ignore: deprecated_member_use
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
