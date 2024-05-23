
import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';

abstract class AuthLocalDatasource {
  Future<User?> getLogin();
  Future<bool>saveLoginData({required LoginData data});
  LoginData getLoginData();
  Future<bool>removeLoginData();
  
}

@LazySingleton(as: AuthLocalDatasource)
class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final SharedPreferanceService _pref;
  AuthLocalDatasourceImpl(this._pref);

  @override
  Future<User?> getLogin() async {
    try {
      final results = await _pref.getUser();
      return results;
    } on CacheException catch (er) {
      throw CacheException(er.msg);
    }
  }
  
  @override
  Future<bool> saveLoginData({required LoginData data})async {
    try{
      final loginData = await _pref.setString(key: SharefPrefKey.loginData, value: jsonEncode(data.toJson()));
      return loginData;
    }on CacheException catch(e){
      throw CacheException(e.msg);
    }
  }
  
  @override
  LoginData getLoginData() {
    try{
      final loginData =  _pref.getString(key: SharefPrefKey.loginData);
      Map<String,dynamic> mapData = loginData==null?{}:jsonDecode(loginData);
      return LoginData.fromJson(mapData);
    }on CacheException catch(e){
      throw CacheException(e.msg);
    }
  }
  
  @override
  Future<bool> removeLoginData()async {
    try{
      return await _pref.deleteData(key: SharefPrefKey.loginData);
    }on CacheException catch(e){
      throw CacheException(e.msg);
    }
  }
}
