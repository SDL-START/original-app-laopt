import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/models/insurance.dart';
import '../../../../core/models/insurance_package.dart';

abstract class BuyInsuranceRemoteDatasource {
  Future<List<Insurance>> getInsuranceType();
  Future<List<InsurancePackage>> getInsurancePackage({required int id});
}

@LazySingleton(as: BuyInsuranceRemoteDatasource)
class BuyInsuranceRemoteDatasourceImpl implements BuyInsuranceRemoteDatasource {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;

  BuyInsuranceRemoteDatasourceImpl(this._networkCall, this._pref);
  @override
  Future<List<Insurance>> getInsuranceType() async {
    try {
      final token = await _pref.getUserToken();
      final res = await _networkCall.getInsuranceType(token ?? '');
      return res;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<InsurancePackage>> getInsurancePackage({required int id}) async {
    try {
      final token = await _pref.getUserToken();
      final res = await _networkCall.getInsurancePackage(token ?? '', id);
      return res;
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw ServerException(e.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
