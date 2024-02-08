import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/change_password.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/models/purpose.dart';

import '../../../../core/models/response_data.dart';
import '../../../../core/models/user.dart';

abstract class SettingsRepository{
  Future<Either<Failure,String?>>getLanguage();
  Future<Either<Failure,User?>>getUserInfo();
  Future<Either<Failure,bool>>logOut();
  Future<Either<Failure,ResponseData>>changePassword({required ChangePassword data,required String token});
  Future<Either<Failure,List<Purpose>>>getPurposes();
  Future<Either<Failure,List<Province>>>getProvinces();
  Future<Either<Failure,User>>updateProfile({required User data});

}