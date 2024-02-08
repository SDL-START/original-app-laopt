import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/user.dart';

abstract class AppLocalDataSource {
  User getLocalUser();
}

@LazySingleton(as: AppLocalDataSource)
class AppLocalDataSourceImpl implements AppLocalDataSource {
  final SharedPreferanceService _pref;
  AppLocalDataSourceImpl(
    this._pref,
  );

  @override
  User getLocalUser() {
    try {
      final user = _pref.getString(key: SharefPrefKey.user);
      final Map<String, dynamic>? mapUser =
          user == null ? {} : jsonDecode(user);
      User data = User.fromJson(mapUser ?? {});
      return data;
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
