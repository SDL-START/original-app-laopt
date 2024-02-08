import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/confirm_otp.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/models/purpose.dart';
import 'package:insuranceapp/core/models/register.dart';
import 'package:insuranceapp/core/models/register_data.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/features/settings/domain/usecase/get_province_usecase.dart';
import 'package:insuranceapp/features/settings/domain/usecase/get_purposes_usecase.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/entities/dropdowns.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../domain/usecases/confirm_otp_usecase.dart';
import '../../domain/usecases/register_request_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/upload_register_usecase.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRequestUescase _registerRequestUescase;
  final ConfirmOTPUsecase _confirmOTPUsecase;
  final GetPurposesUsecase _getPurposesUsecase;
  final GetProvinceUsecase _getProvinceUsecase;
  final UploadRegisterUsecase _uploadRegisterUsecase;
  final RegisterUsecase _registerUsecase;
  RegisterCubit(
    this._registerRequestUescase,
    this._confirmOTPUsecase,
    this._getPurposesUsecase,
    this._getProvinceUsecase,
    this._uploadRegisterUsecase,
    this._registerUsecase,
  ) : super(const RegisterState());

  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> formOTP = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> formPurpose = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> formPassword = GlobalKey<FormBuilderState>();

  TextEditingController otpController = TextEditingController();

  ValidateType? type = ValidateType.PHONE;
  Map<String, dynamic> formValue = {};
  Map<String, dynamic> purposeValue = {};

  String passport = "";
  String vaccine = "";
  String rtpcr = "";

  final ImagePicker _picker = ImagePicker();

  List<Dropdowns> listGender = [
    Dropdowns(
      name: LocaleKeys.kMale.tr(),
      value: "MALE",
    ),
    Dropdowns(
      name: LocaleKeys.kFemale.tr(),
      value: "FEMALE",
    ),
    Dropdowns(
      name: LocaleKeys.kOther.tr(),
      value: "Other",
    ),
  ];

  List<Dropdowns> listPurposes = [];
  List<Dropdowns> listProvinces = [];

  Future<void> getProvinces() async {
    emit(state.copyWith(status: RegisterStatus.LOADING));
    final result = await _getProvinceUsecase(NoParams());
    result.fold(
        (er) =>
            emit(state.copyWith(status: RegisterStatus.FAILURE, error: er.msg)),
        (provinces) {
      for (Province pv in provinces) {
        listProvinces.add(Dropdowns(
            name: Utils.getTranslate(
              AppNavigator.navigatorKey!.currentContext!,
              pv.name,
            ),
            value: pv.id));
      }
      emit(state.copyWith(
        status: RegisterStatus.LAODED,
        listProvince: provinces,
      ));
    });
  }

  Future<void> getPurposes() async {
    emit(state.copyWith(status: RegisterStatus.LOADING));
    final result = await _getPurposesUsecase(NoParams());
    result.fold(
        (er) =>
            emit(state.copyWith(status: RegisterStatus.FAILURE, error: er.msg)),
        (purpose) {
      for (Purpose pur in purpose) {
        listPurposes.add(Dropdowns(
            name: Utils.getTranslate(
                AppNavigator.navigatorKey!.currentContext!, pur.name),
            value: pur.code));
      }
      emit(state.copyWith(
        status: RegisterStatus.LAODED,
        listPurpose: purpose,
      ));
    });
  }

  void onChangedType({ValidateType? value}) {
    emit(state.copyWith(status: RegisterStatus.LOADING));
    type = value;
    emit(state.copyWith(status: RegisterStatus.LAODED));
  }

  Future<void> requestRegister() async {
    if (formKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: RegisterStatus.LOADING));
      String typeData = (type == ValidateType.PHONE) ? "phone" : "email";
      formValue = Map.of(formKey.currentState?.value ?? {});
      formValue['type'] = typeData;
      RegisterData data = RegisterData.fromJson(formValue);
      final result = await _registerRequestUescase(data);
      result.fold(
          (l) {
            emit(state.copyWith(status: RegisterStatus.FAILURE, error: l.msg));
          },
          (r) {
        emit(state.copyWith(status: RegisterStatus.REQUESTED));
      });
    }
  }

  Future<void> onConfirmOTP() async {
    if (formOTP.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: RegisterStatus.LOADING));
      formValue['otp'] = formOTP.currentState?.value['otp'];
      formValue['code'] = formOTP.currentState?.value['otp'];
      ConfirmOTP value = ConfirmOTP.fromJson(formValue);
      final result = await _confirmOTPUsecase(value);
      result.fold((er) {
        emit(state.copyWith(status: RegisterStatus.FAILURE, error: er.msg));
      }, (r) {
        emit(state.copyWith(status: RegisterStatus.CONFIRMED));
      });
    }
  }

  Future<void> onSubmitPurpose() async {
    if (formPurpose.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: RegisterStatus.LOADING));
      try {
        Map<String, dynamic> purposeValue =
            Map<String, dynamic>.of(formPurpose.currentState?.value ?? {});
        purposeValue['idtype'] = "PASSPORT";
        purposeValue['countrycode'] = "LA";
        formValue.addAll({...purposeValue});
      } catch (er) {
        emit(state.copyWith(
            status: RegisterStatus.FAILURE, error: er.toString()));
      }
      emit(state.copyWith(status: RegisterStatus.PURPOSED));
    } else {
      print("Purpose form");
    }
  }

  Future<void> getImage(
      {required ImageSource source, required FileType type}) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await uploadImage(file: file, type: type);
    } else {
      print("No Image file");
    }
  }

  Future<void> uploadImage({required File file, required FileType type}) async {
    emit(state.copyWith(status: RegisterStatus.LOADING));
    final result = await _uploadRegisterUsecase(file);
    result.fold(
        (er) => emit(
            state.copyWith(status: RegisterStatus.UPLOAD_FAILE, error: er.msg)),
        (res) {
      if (type == FileType.passport) {
        passport = res.name ?? '';
        formValue['photopassport'] = res.name;
      } else if (type == FileType.vaccine) {
        vaccine = res.name ?? '';
        formValue['photovaccine'] = res.name;
      } else {
        rtpcr = res.name ?? '';
        formValue['photortpcr'] = res.name;
      }
      emit(state.copyWith(status: RegisterStatus.UPLOADED));
    });
  }

  Future<void> registerPassword() async {
    if (formPassword.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: RegisterStatus.LOADING));
      Map<String, dynamic> fromData =
          Map<String, dynamic>.of(formPassword.currentState?.value ?? {});
      String? password = fromData['newpassword'];
      String? conFirmPassword = fromData['confirmpassword'];
      if (password != conFirmPassword) {
        emit(state.copyWith(status: RegisterStatus.VALIDAT_FAILE));
      } else {
        formValue["password"] = password;
        Register data = Register.fromJson(formValue);
        final result = await _registerUsecase(data);
        result.fold((er) {
          emit(state.copyWith(status: RegisterStatus.FAILURE, error: er.msg));
        }, (res) {
          emit(state.copyWith(status: RegisterStatus.REGISTER_SUCCESS));
        });
      }
    } else {
      print("form password");
    }
  }
}
