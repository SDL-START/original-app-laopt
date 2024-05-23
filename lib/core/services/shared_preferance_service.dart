import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/menu.dart';
import '../models/pt_image.dart';
import '../models/user.dart';

@injectable
class SharedPreferanceService {
  final SharedPreferences prefs;
  SharedPreferanceService(this.prefs);

  //String section
  String? getString({required String key}) {
    try {
      return prefs.getString(key);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  Future<bool> setString({required String key, required String value}) async {
    try {
      return prefs.setString(key, value);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  //Int section
  Future<int?> getInt({required String key}) async {
    try {
      return prefs.getInt(key);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  Future<bool> setInt({required String key, required int value}) async {
    try {
      return prefs.setInt(key, value);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  Future<bool> deleteData({required String key}) async{
    try {
      return await prefs.remove(key);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  Future<bool> deleteAll() async {
    try {
      return prefs.clear();
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  Future<String?> getUserToken() async {
    try {
      final user = prefs.getString(SharefPrefKey.user);
      final Map<String, dynamic>? mapUser =
          user == null ? {} : jsonDecode(user);
      User data = User.fromJson(mapUser ?? {});
      return data.token;
    } catch (er) {
      print("Error get user token");
      throw CacheException(er.toString());
    }
  }

  Future<User> getUser() async {
    try {
      final user = prefs.getString(SharefPrefKey.user);
      final Map<String, dynamic>? mapUser =
          (user == null) ? {} : jsonDecode(user);
      User data = User.fromJson(mapUser ?? {});
      return data;
    } catch (er) {
      print("Error get user");
      throw CacheException(er.toString());
    }
  }

  Future<bool> setUser({required User user}) async {
    try {
      final userData = user.toJson();
      final userStr = jsonEncode(userData);
      return await prefs.setString(SharefPrefKey.user, userStr);
    } catch (e) {
      print("Error set user");
      throw CacheException(e.toString());
    }
  }
  
  Future<bool>saveSlideImage({required List<PTImage> listSide})async{
    String jsonStr = jsonEncode(listSide.map((e) => e.toJson()).toList());
    return await prefs.setString(SharefPrefKey.slideImage, jsonStr);
  }

  List<PTImage>? getSlideImage(){
    String? jsonStr = prefs.getString(SharefPrefKey.slideImage);
    if(jsonStr!=null){
      final List listData = jsonDecode(jsonStr);
      List<PTImage> list = listData.map((e) => PTImage.fromJson(e)).toList();
      return list;
    }else{
      return null;
    }
  }

  Future<bool>saveMenu({required List<Menu> menuList})async{
    String jsonStr = jsonEncode(menuList.map((e) => e.toJson()).toList());
    return await prefs.setString(SharefPrefKey.menu, jsonStr);
  }

  List<Menu>? getMenuLocal(){
    String? jsonStr = prefs.getString(SharefPrefKey.menu);
    if(jsonStr!=null){
      final List listData = jsonDecode(jsonStr);
      List<Menu> list = listData.map((e) => Menu.fromJson(e)).toList();
      return list;
    }else{
      return null;
    }
  }

}
