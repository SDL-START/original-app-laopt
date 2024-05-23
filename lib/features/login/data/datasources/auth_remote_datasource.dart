import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/models/languages.dart';
import 'package:insuranceapp/core/models/login.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/location_service.dart';
import 'package:insuranceapp/core/services/push_nitification_service.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/constants/constant.dart';

abstract class AuthRemoteDataSource {
  Future<List<Languages>> getLanguage();
  // Future<List<Translations>> getTranslation();
  Future<User> login({required Login loginData});
  Future<List<Hospital>> getHospital();
  Future<bool> getInitalPlatform();
  Future<String?> getFirebaseToken();
  Future<User?>forgotPassword({required Map<String,dynamic> data});
  Future<dynamic>resetPassword({required Map<String,dynamic> data});
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final NetworkCall networkCall;
  final LocationService locationService;
  final PushNotificationService _notificationService;
  final SharedPreferanceService _pref;

  AuthRemoteDataSourceImpl(
    this.networkCall,
    this.locationService,
    this._notificationService,
    this._pref,
  );
  @override
  Future<List<Languages>> getLanguage() async {
    try {
      final res = await networkCall.getLanguage();
      if (res.isNotEmpty) {
        // for (Languages lang in res) {
        //   await databaseService.setData<Languages>(
        //       key: DatabaseKey.languageKey, data: lang);
        // }
      }

      return res;
    } on DioError catch (err) {
      throw ServerException(err.message);
    }
  }


  @override
  Future<User> login({required Login loginData}) async {
    try {
      final response = await networkCall.login(loginData.toJson());
      await _pref.setString(key: SharefPrefKey.user, value: jsonEncode(response.toJson()));
      return response;
    } on DioError catch (er) {
      throw ServerException(er.response?.data['message']);
    }
  }

  @override
  Future<List<Hospital>> getHospital() async {
    try {
      final res = await networkCall.getHospital();
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    }
  }

  @override
  Future<bool> getInitalPlatform() async {
    try {
      await locationService.initPlatformState();
      return true;
    } on PlatformException catch (e) {
      throw ServerException(e.message ?? e.code);
    }
  }

  @override
  Future<String?> getFirebaseToken() async {
    try {
      final res = await _notificationService.getFirebaseToken();
      return res;
    } catch (error) {
      throw ServerException(error.toString());
    }
  }
  
  @override
  Future<User?> forgotPassword({required Map<String, dynamic> data})async {
    return await networkCall.forgotPassword(jsonEncode(data));
  }
  
  @override
  Future<dynamic> resetPassword({required Map<String, dynamic> data}) async{
    return await networkCall.resetPassword(jsonEncode(data));
  }
}
