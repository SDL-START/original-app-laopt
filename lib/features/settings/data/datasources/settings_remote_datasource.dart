import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/change_password.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';
import '../../../../core/models/purpose.dart';
import '../../../../core/models/response_data.dart';
import '../../../../core/models/user.dart';

abstract class SettingsRemoteDatasourec {
  Future<ResponseData> changePassword(
      {required ChangePassword data, required String token});
  Future<List<Purpose>> getPurposes();
  Future<List<Province>> getProvinces();
  Future<User> updateProfile({required User data});
}

@LazySingleton(as: SettingsRemoteDatasourec)
class SettingsRemoteDatasourecImpl implements SettingsRemoteDatasourec {
  final NetworkCall networkCall;
  final SharedPreferanceService pref;

  SettingsRemoteDatasourecImpl(this.networkCall, this.pref);
  @override
  Future<ResponseData> changePassword(
      {required ChangePassword data, required String token}) async {
    try {
      final res = await networkCall.changePassword(token, data.toJson());
      return res;
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<Purpose>> getPurposes() async {
    try {
      return await networkCall.getPurpose();
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }

  @override
  Future<List<Province>> getProvinces() async {
    try {
      return await networkCall.getProvinces();
    } on DioError catch (error) {
    throw ServerException(error.message);
    }
  }

  @override
  Future<User> updateProfile({required User data}) async {
    try {
      final user = await pref.getUser();
      final res = await networkCall.updateProfile(user.token ?? "", data.toJson());
      await pref.setUser(user: user);
      return res;
    } on DioError catch (error) {
      throw ServerException(error.message);
    }
  }
}
