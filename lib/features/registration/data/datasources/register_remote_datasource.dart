import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/register.dart';
import 'package:insuranceapp/core/models/register_data.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/confirm_otp.dart';

abstract class RegisterRemoteDatasourec {
  Future<User> registerRequest({required RegisterData data});
  Future<ResponseData> confirmOTP({required ConfirmOTP data});
  Future<ResponseData> uploadFile({required File file});
  Future<dynamic> register({required Register data});
}

@LazySingleton(as: RegisterRemoteDatasourec)
class RegisterRemoteDatasourecImpl implements RegisterRemoteDatasourec {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;

  RegisterRemoteDatasourecImpl(this._networkCall,this._pref);

  Future<User?> getCurrenUser() async {
    try {
      final res =_pref.getUser();
      return res;
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  @override
  Future<User> registerRequest({required RegisterData data}) async {
    try {
      final res = await _networkCall.registerRequest(data.toJson());
      return res;
    } on DioError catch (er) {
      throw ServerException(er.response?.data['message']);
    }
  }

  @override
  Future<ResponseData> confirmOTP({required ConfirmOTP data}) async {
    try {
      final user = await getCurrenUser();
      final res =
          await _networkCall.confirmOTP(user?.token ?? '', data.toJson());
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    }
  }
  
  @override
  Future<ResponseData> uploadFile({required File file})async {
    try {
      final res =await _networkCall.registerUploadFile(file);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    }
  }
  
  @override
  Future register({required Register data})async {
     try {
      print(jsonEncode(data.toJson()));
      final res =await _networkCall.register(data.toJson());
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    }
  }
}
