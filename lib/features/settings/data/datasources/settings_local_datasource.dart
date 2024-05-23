import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/error/exceptions.dart';

abstract class SettingsLocalDatasource {
  Future<String?> getLanguage();
  Future<User?> getUserInfo();
  Future<bool> logOut();
}

@LazySingleton(as: SettingsLocalDatasource)
class SettingsLocalDatasourceImpl implements SettingsLocalDatasource {
  final SharedPreferanceService pref;
  SettingsLocalDatasourceImpl(this.pref);
  @override
  Future<String?> getLanguage() async {
    try {
      final res = pref.getString(key: SharefPrefKey.langCode);
      return res;
    } on CacheException catch (error) {
      throw CacheException(error.msg);
    }
  }

  @override
  Future<User?> getUserInfo() async {
    try {
      final res = await pref.getUser();
      return res;
    } on CacheException catch (error) {
      throw CacheException(error.msg);
    }
  }

  @override
  Future<bool> logOut() async {
    try {
      Future.wait([
        pref.deleteData(key: SharefPrefKey.user),
        pref.deleteData(key: SharefPrefKey.slideImage),
        pref.deleteData(key: SharefPrefKey.menu),
      ]);
      return true;
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
