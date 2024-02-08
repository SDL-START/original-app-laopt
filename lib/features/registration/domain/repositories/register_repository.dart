import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/register.dart';
import 'package:insuranceapp/core/models/response_data.dart';

import '../../../../core/models/confirm_otp.dart';
import '../../../../core/models/register_data.dart';
import '../../../../core/models/user.dart';

abstract class RegisterRepository{
  Future<Either<Failure,User>>registerRequest({required RegisterData data});
  Future<Either<Failure,ResponseData>>confirmOTP({required ConfirmOTP data});
  Future<Either<Failure,ResponseData>>uploadFile({required File file});
  Future<Either<Failure,dynamic>>register({required Register data});
}