import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/models/languages.dart';
import 'package:insuranceapp/core/models/login.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';

abstract class AuthRepository {
  Future<Either<Failure,User>>login({required Login loginData});
  Future<Either<Failure,List<Languages>>>getLanguage();
  Future<Either<Failure,User?>>getLogin();
  Future<Either<Failure,List<Hospital>>>getHospital();
  Future<Either<Failure,bool>>getInitialPlatform();
  Future<Either<Failure,String?>>getFirebaseToken();
  Future<Either<Failure,User?>>forgotPassword({required Map<String,dynamic>data});
  Future<Either<Failure,dynamic>>resetPassword({required Map<String,dynamic>data});
  LoginData getLoginData();
  Future<Either<Failure, bool>>saveLoginData({required LoginData data});
  Future<Either<Failure, bool>>removeLoginData();
}