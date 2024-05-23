import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/features/chats/domain/usecases/get_user_usecase.dart';
import 'package:insuranceapp/generated/assets.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:intl_phone_field/countries.dart';

import '../../../../core/entities/dropdowns.dart';
import '../../../../core/models/change_password.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/domain/usecases/upload_file_usecase.dart';
import '../../domain/usecase/change_password_usecase.dart';
import '../../domain/usecase/get_language_usecase.dart';
import '../../domain/usecase/get_province_usecase.dart';
import '../../domain/usecase/get_purposes_usecase.dart';
import '../../domain/usecase/get_user_info_usecase.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../domain/usecase/update_profile_usecase.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final GetLanguaseUsecase _getLanguaseUsecase;
  final GetUserInfoUsecase _getUserInfoUsecase;
  final GetPurposesUsecase _getPurposesUsecase;
  final GetProvinceUsecase _getProvinceUsecase;
  final UploadFileUsecase _uploadFileUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final ChangePasswordUsecase _changePasswordUsecase;
  final LogoutUsecase _logoutUsecase;
  SettingsCubit(
    this._getLanguaseUsecase,
    this._getUserInfoUsecase,
    this._getPurposesUsecase,
    this._getProvinceUsecase,
    this._uploadFileUsecase,
    this._updateProfileUsecase,
    this._getUserByIdUsecase,
    this._changePasswordUsecase,
    this._logoutUsecase,
  ) : super(const SettingsState());

  GlobalKey<FormBuilderState> profileKey = GlobalKey<FormBuilderState>();
  GlobalKey<FormBuilderState> formResetKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  TextEditingController phoneController = TextEditingController();
  String? number;
  String? phoneCode;
  Country? countryPhone;
  String? profilePhoto;
  String? passportPhoto;
  String? vaccinePhoto;
  String? rtpcrPhoto;

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
  //Get language code from locale
  Future<void> getLanguage() async {
    emit(state.copyWith(status: DataStatus.loading));
    final lang = await _getLanguaseUsecase(NoParams());
    if (lang.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: lang.getLeft()?.msg));
    } else {
      emit(state.copyWith(
          status: DataStatus.success, languageCode: lang.getRight() ?? 'en'));
    }
  }

  Future<void> getUserInfo() async {
    final result = await _getUserInfoUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (user) {
      emit(state.copyWith(
        currentUser: user,
      ));
    });
  }

  Future<void> getUserProfile() async {
    emit(state.copyWith(status: DataStatus.loading));
    await getPurpose();
    await getProvinces();
    await getUserInfo();
    final userProfile = await _getUserByIdUsecase(state.currentUser?.id ?? 0);
    userProfile.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (profile) {
      if (profile.photo != null && profile.photo!.isNotEmpty) {
        Map<String, dynamic> photo = jsonDecode(profile.photo ?? "{}");
        profilePhoto = photo["photoprofile"];
        passportPhoto = photo["photopassport"];
        vaccinePhoto = photo["photovaccine"];
        rtpcrPhoto = photo["photortpcr"];
      }

      if (profile.phone != null && profile.phone!.isNotEmpty) {
        number = profile.phone?.substring((profile.phone?.length ?? 0) - 10);
        phoneCode = profile.phone?.substring(1, 4);
        countryPhone = countries.firstWhere(
            (element) => element.dialCode.startsWith(phoneCode ?? ''));
      }
      phoneController.text = number ?? "";
      emit(
        state.copyWith(
          status: DataStatus.success,
          userProfile: profile,
          profilePhoto: profilePhoto,
          phoneNumber: number,
          phoneCountry: countryPhone?.code ?? "LA",
          passportPhoto: passportPhoto,
          vaccinePhoto: vaccinePhoto,
          RTPCRPhoto: rtpcrPhoto,
        ),
      );
    });
  }

  Future<void> getPurpose() async {
    final purpose = await _getPurposesUsecase(NoParams());
    if (purpose.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: purpose.getLeft()?.msg));
    } else {
      List<Dropdowns>? listPurposes = purpose
          .getRight()
          ?.map((e) => Dropdowns(
              name: Utils.getTranslate(
                  AppNavigator.navigatorKey!.currentContext!, e.name),
              value: e.code))
          .toList();
      emit(state.copyWith(listPurposes: listPurposes ?? []));
    }
  }

  Future<void> getProvinces() async {
    final provinces = await _getProvinceUsecase(NoParams());
    if (provinces.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: provinces.getLeft()?.msg));
    } else {
      List<Dropdowns>? listProvince = provinces
          .getRight()
          ?.map((e) => Dropdowns(
              name: Utils.getTranslate(
                  AppNavigator.navigatorKey!.currentContext!, e.name),
              value: e.id))
          .toList();
      emit(state.copyWith(listProvince: listProvince ?? []));
    }
  }

  String onGenerateFlag({required String code}) {
    if (code.toLowerCase() == "en") {
      return Assets.flagsUs;
    } else if (code.toLowerCase() == "lo") {
      return Assets.flagsLa;
    } else if (code.toLowerCase() == "zh") {
      return Assets.flagsCn;
    } else if (code.toLowerCase() == "vi") {
      return Assets.flagsVn;
    } else {
      return Assets.imagesEn;
    }
  }

  Future<void> getImage(
      {required ImageSource source, required FileType type}) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await uploadImage(file: file, type: type);
    }
  }

  Future<void> uploadImage({required File file, required FileType type}) async {
    final result = await _uploadFileUsecase(file);
    if (result.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: result.getLeft()?.msg));
    } else {
      if (type == FileType.passport) {
        emit(state.copyWith(passportPhoto: result.getRight()?.name));
      } else if (type == FileType.vaccine) {
        emit(state.copyWith(vaccinePhoto: result.getRight()?.name));
      } else if (type == FileType.rtpcr) {
        emit(
          state.copyWith(RTPCRPhoto: result.getRight()?.name),
        );
      } else {
        emit(state.copyWith(profilePhoto: result.getRight()?.name));
      }
    }
  }

  void onChangedPurpose() {}
  void onChangedPhoneCountry({required String countryCode}) {
    phoneCode = countryCode;
  }

  Future<void> onSaveProfile() async {
    emit(state.copyWith(status: DataStatus.loading));
    if (profileKey.currentState!.saveAndValidate() &&
        state.passportPhoto != null &&
        phoneController.text.isNotEmpty) {
      Map<String, dynamic> formValue =
          Map.of(profileKey.currentState?.value ?? {});
      formValue['photo'] = jsonEncode({
        'photopassport': state.passportPhoto,
        'photovaccine': state.vaccinePhoto,
        'photortpcr': state.RTPCRPhoto,
        'photoprofile': state.profilePhoto
      });
      formValue["phone"] = "$phoneCode${phoneController.text}";
      Map<String, dynamic> data = state.userProfile?.toJson() ?? {};
      formValue.forEach((key, value) {
        data[key] = value;
      });
      User user = User.fromJson(data);
      final result = await _updateProfileUsecase(user);
      if (result.isLeft()) {
        emit(state.copyWith(
            status: DataStatus.failure, error: result.getLeft()?.msg));
      } else {
        await getUserProfile();
      }
    } else {
      String errorMsg = "";
      if (state.passportPhoto == null || state.passportPhoto == '') {
        errorMsg = "Please upload your passport photo";
      } else if (phoneController.text.isEmpty) {
        errorMsg = "Phone number can not empty";
      } else {
        errorMsg = "Something went wrong";
      }
      emit(
        state.copyWith(
          status: DataStatus.failure,
          error: errorMsg,
        ),
      );
    }
  }

  Future<void> onChagePassword() async {
    if (formResetKey.currentState!.saveAndValidate()) {
      emit(state.copyWith(status: DataStatus.loading));
      Map<String, dynamic> formValue =
          Map.of(formResetKey.currentState?.value ?? {});
      //Hash password
      formValue["currentPassword"] =
          Utils.hash(value: formValue["currentPassword"]);
      formValue["newPassword"] = Utils.hash(value: formValue["newPassword"]);
      formValue["confirmPassword"] =
          Utils.hash(value: formValue["confirmPassword"]);
      formValue["userid"] = state.currentUser?.id;
      ChangePassword data = ChangePassword.fromJson(formValue);
      if (data.newPassword != data.confirmPassword) {
        emit(state.copyWith(
            status: DataStatus.failure, error: "Your password is not match"));
      } else {
        final result = await _changePasswordUsecase(ChangePasswordParams(
            data: data, token: state.currentUser?.token ?? ''));
        result.fold(
            (er) =>
                emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
            (res) {
          emit(state.copyWith(
            status: DataStatus.success,
          ));
        });
      }
    }
  }

  Future<void> logOut() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _logoutUsecase(NoParams());
    if (result.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: result.getLeft()?.msg));
    } else {
      emit(state.copyWith(status: DataStatus.logout));
    }
  }
}
