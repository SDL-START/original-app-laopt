import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/network/network_call.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/models/hospital.dart';

abstract class HospitalRemoteDatasource {
  Future<List<Hospital>> getHospitalService();
}

@LazySingleton(as: HospitalRemoteDatasource)
class HospitalRemoteDatasourceImpl implements HospitalRemoteDatasource{
  final NetworkCall _networkCall;

  HospitalRemoteDatasourceImpl(this._networkCall);
  
  @override
  Future<List<Hospital>> getHospitalService() async{
    try {
      final res = await _networkCall.getHospitalService();
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }catch (e){
      throw CacheException(e.toString());
    }
  }
}