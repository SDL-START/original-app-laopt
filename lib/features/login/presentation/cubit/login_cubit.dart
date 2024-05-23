import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/models/login.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/usecases/get_firebase_token_usecase.dart';
import '../../domain/usecases/get_login_data_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/remove_login_data_usecase.dart';
import '../../domain/usecases/request_forgot_password_usecase.dart';
import '../../domain/usecases/reset_password_usecase.dart';
import '../../domain/usecases/save_login_data_usecase.dart';

part 'login_cubit.freezed.dart';
part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final GetLoginDataUseCase _getLoginDataUseCase;
  final GetFirebaseTokenusecase _firebaseTokenUseCase;
  final LoginUsecase _loginUsecase;
  final SaveLoginDataUsecase _saveLoginDataUsecase;
  final RemoveLoginDataUsecase _removeLoginDataUsecase;
  final RequestForgotPasswordUsecase _forgotPasswordUsecase;
  final ResetPasswordUsecase _resetPasswordUsecase;
  LoginCubit(
    this._getLoginDataUseCase,
    this._firebaseTokenUseCase,
    this._loginUsecase,
    this._saveLoginDataUsecase,
    this._removeLoginDataUsecase,
    this._forgotPasswordUsecase,
    this._resetPasswordUsecase,
  ) : super(const LoginState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? phoneNumber;
  String? codeNumber;
  String? codeString;

  GlobalKey<FormState> formForgotKey = GlobalKey<FormState>();

  GlobalKey<FormBuilderState> resetFormKey = GlobalKey<FormBuilderState>();

  Future<void> initial() async {
    if (super.isClosed == true) return;
    emit(state.copyWith(status: DataStatus.loading));
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    emit(
      state.copyWith(
        status: DataStatus.success,
        packageInfo: packageInfo,
      ),
    );
  }

  Future<void> getLoginData({required bool isPhone}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final loginData = _getLoginDataUseCase(NoParams());
    emailController.text = loginData.email ?? '';
    phoneNumber = loginData.phoneNumber;
    codeNumber = loginData.codeNumber;
    codeString = loginData.codeString;
    emit(state.copyWith(status: DataStatus.success, loginData: loginData));
  }

  Future<void> getFirbaseToken() async {
    final firebaseToken = await _firebaseTokenUseCase(NoParams());
    if (firebaseToken.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: firebaseToken.getLeft()?.msg));
    } else {
      print("Firebase token -> ${firebaseToken.getRight()}");
      emit(state.copyWith(firebaseToken: firebaseToken.getRight()));
    }
  }

  Future<void> login({required bool isPhone}) async {
    bool validate = isPhone ? phoneNumber != null && phoneNumber != "" : true;
    if (formKey.currentState!.validate() && validate) {
      emit(state.copyWith(status: DataStatus.loading));
      Map<String, dynamic> formValue = {};
      formValue['firebasetoken'] = state.firebaseToken;
      formValue['password'] = Utils.hash(value: passwordController.text);
      if (isPhone) {
        formValue['username'] = "+$codeNumber$phoneNumber";
      } else {
        formValue['username'] = emailController.text;
      }
      Login data = Login.fromJson(formValue);
      final result = await _loginUsecase(LoginParams(loginData: data));
      result.fold((er) {
        emit(state.copyWith(status: DataStatus.failure, error: er.msg));
      }, (res) async {
        if (state.rememberMe == true) {
          LoginData loginData = LoginData(
            codeNumber: codeNumber,
            phoneNumber: phoneNumber,
            email: emailController.text,
            codeString: codeString,
          );
          await _saveLoginDataUsecase(loginData);
        } else {
          await _removeLoginDataUsecase(NoParams());
        }
        AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
      });
    } else {
      debugPrint("Required field");
      emit(state.copyWith(validated: false));
    }
  }

  void onChangedPhoneNumber(PhoneNumber value) {
    if (value.number == "") {
      emit(state.copyWith(validated: false));
    } else {
      phoneNumber = value.number;
      emit(state.copyWith(validated: true));
    }
  }

  void onChangedPhoneCountryr(Country value) {
    codeNumber = value.dialCode;
    codeString = value.code;
  }

  void onChangedRememberMe(bool value) {
    emit(state.copyWith(rememberMe: value));
  }

  void onChangedType({ValidateType? value}) {
    emit(state.copyWith(forgotType: value ?? ValidateType.PHONE));
  }

  Future<void> forgotRequest() async {
    bool validate = (state.forgotType == ValidateType.PHONE)
        ? phoneNumber != null && phoneNumber != ""
        : true;
    if (formForgotKey.currentState!.validate() && validate) {
      emit(state.copyWith(status: DataStatus.loading));
      Map<String, dynamic> formValue = {};
      if (state.forgotType == ValidateType.PHONE) {
        formValue['phone'] = "$codeNumber$phoneNumber";
        formValue['email'] = "";
        formValue['type'] = "phone";
      } else {
        formValue['phone'] = "";
        formValue['email'] = emailController.text;
        formValue['type'] = "email";
      }
      final request = await _forgotPasswordUsecase(formValue);
      request.fold((er) {
        emit(state.copyWith(status: DataStatus.failure, error: er.msg));
      }, (res) {
        emit(state.copyWith(status: DataStatus.success, requestData: res));
      });
    } else {
      emit(state.copyWith(validated: false));
    }
  }

  Future<void> resetPassword() async {
    if (resetFormKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: DataStatus.loading));
      Map<String, dynamic> formData =
          Map.of(resetFormKey.currentState?.value ?? {});
      if (formData['newPassword'] != formData['confirm']) {
        emit(state.copyWith(
            status: DataStatus.failure, error: 'Password not match'));
      } else {
        final data = {
          'id': state.requestData?.id,
          'otp': formData['otp'],
          'email': state.requestData?.email,
          'phone': state.requestData?.phone,
          'type': (state.forgotType == ValidateType.EMAIL) ? "email" : "phone",
          'password': formData['confirm'],
        };
        final reset = await _resetPasswordUsecase(data);
        reset.fold((er) {
          emit(state.copyWith(status: DataStatus.failure, error: er.msg));
        }, (res) {
          AppNavigator.pushAndRemoveUntil(AppRoute.initialRoute);
        });
      }
    }
  }
}
