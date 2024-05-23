import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

abstract class LangLocalDataSource {
  String? getLangCode();
  Future<bool> setLangCode({required String code});
}

@LazySingleton(as: LangLocalDataSource)
class LangLocalDataSourceImpl implements LangLocalDataSource {
  final SharedPreferanceService _pref;

  LangLocalDataSourceImpl(this._pref);

  @override
  String? getLangCode() {
    try {
      final langCode =  _pref.getString(key: SharefPrefKey.langCode);
      return langCode;
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<bool> setLangCode({required String code}) async {
    try {
      final lang =
          await _pref.setString(key: SharefPrefKey.langCode, value: code);
      return lang;
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
