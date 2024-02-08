import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';

import '../../../../core/models/certificate.dart';
import '../../../../core/models/insurance.dart';
import '../../../../core/models/insurance_package.dart';
import '../../../../core/models/photo.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../chats/domain/usecases/get_user_usecase.dart';
import '../../../home/domain/usecases/create_certificate_usecase.dart';
import '../../../home/domain/usecases/upload_file_usecase.dart';
import '../../domain/usecases/get_insurance_package.dart';
import '../../domain/usecases/get_insurance_type_usecase.dart';

part 'buy_insurance_cubit.freezed.dart';
part 'buy_insurance_state.dart';

@injectable
class BuyInsuranceCubit extends Cubit<BuyInsuranceState> {
  final GetInsuranceTypeUsecase _getInsuranceTypeUsecase;
  final GetInsurancePackageUsecase _getInsurancePackageUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  final CreateCertificateUsecase _createCertificateUsecase;
  final UploadFileUsecase _uploadFileUsecase;
  BuyInsuranceCubit(
    this._getInsuranceTypeUsecase,
    this._getInsurancePackageUsecase,
    this._getUserLocalUsecase,
    this._getUserByIdUsecase,
    this._createCertificateUsecase,
    this._uploadFileUsecase,
  ) : super(const BuyInsuranceState());
  GlobalKey<FormBuilderState> formMemberKey = GlobalKey<FormBuilderState>();
  final ImagePicker _picker = ImagePicker();
  String? memberPhotoPassport;
  String? memberPhotoVaccine;
  String? memberPhotoRTPCR;
  Future<void> getInsuranceType() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getInsuranceTypeUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (res) {
      emit(state.copyWith(status: DataStatus.success, listInsurance: res));
    });
  }

  Future<void> getInsurancePackage(Insurance insurance) async {
    emit(state.copyWith(status: DataStatus.loading));
    await getCurrentUser();
    final result = await _getInsurancePackageUsecase(insurance.id ?? 0);
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (listPackage) {
      emit(
        state.copyWith(
          status: DataStatus.success,
          listInsurancePackage: listPackage,
          currentInsurance: insurance,
        ),
      );
    });
  }

  Future<void> getInsuranceMember(
      {required InsurancePackage package,
      required Insurance currentInsurance,
      required User currentUser}) async {
    emit(state.copyWith(status: DataStatus.loading));
    List<User> userMember = List.of(state.packagemembers);
    if (state.includeMe) {
      userMember.add(currentUser);
    }
    emit(state.copyWith(
      status: DataStatus.success,
      packagemembers: userMember,
      currentPackage: package,
      currentInsurance: currentInsurance,
      currentUser: currentUser,
    ));
  }

  Future<void> getCurrentUser() async {
    emit(state.copyWith(status: DataStatus.loading));
    final localUser =  _getUserLocalUsecase(NoParams());
    final user = await _getUserByIdUsecase(localUser.id ?? 0);
    if (user.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: user.getLeft()?.msg));
    } else {
      final userData = user.getRight();
      Photo? userPhoto = (userData?.photo == null || userData?.photo == "")
          ? null
          : Photo.fromJson(jsonDecode(userData!.photo!));
      Map<String, dynamic> userMap = userData?.toJson() ?? {};
      userMap['photopassport'] = userPhoto?.photopassport;
      userMap['photovaccine'] = userPhoto?.photovaccine;
      userMap['photortpcr'] = userPhoto?.photortpcr;
      userMap['photoprofile'] = userPhoto?.photoprofile;
      final currentUser = User.fromJson(userMap);
      emit(
          state.copyWith(status: DataStatus.success, currentUser: currentUser));
    }
  }

  void onChangeIncludeMe(bool value) {
    emit(state.copyWith(status: DataStatus.loading));
    List<User> packageMember = List.of(state.packagemembers);
    if (value) {
      if (packageMember.where((el) => el == state.currentUser).isEmpty) {
        packageMember.insert(0, state.currentUser!);
      }
    } else {
      packageMember.removeWhere((element) => element == state.currentUser);
    }
    emit(state.copyWith(
        status: DataStatus.success,
        includeMe: value,
        packagemembers: packageMember));
  }

  Future<void> createCertificate() async {
    emit(state.copyWith(status: DataStatus.loading));
    double packagePrice = (state.currentPackage?.price == null)
        ? 0.0
        : double.parse(state.currentPackage!.price!);
    double amount = packagePrice * state.packagemembers.length;

    Certificate certificate = Certificate(
      amount: amount,
      typeid: state.currentPackage?.insurancetype_id,
      packageid: state.currentPackage?.id,
      userid: state.currentUser?.id,
      members: state.packagemembers,
      type: state.packagemembers.length > 1 ? "FAMILY" : "SINGLE",
    );
    final result =
        await _createCertificateUsecase(CreateCertificateParams(certificate));
    result.fold(
      (e) => emit(state.copyWith(status: DataStatus.failure, error: e.msg)),
      (res) {
        AppNavigator.pushAndRemoveUntil(AppRoute.myInsuranceDetail,
            params: res.certificate);
      },
    );
  }

  void clearData() {
    memberPhotoPassport = "";
    memberPhotoVaccine = "";
    memberPhotoRTPCR = "";
  }

  Future<void> addMember() async {
    if (formMemberKey.currentState!.saveAndValidate() &&
        memberPhotoPassport != null &&
        memberPhotoPassport!.isNotEmpty) {
      emit(state.copyWith(status: DataStatus.loading));

      List<User> packageMember = List.of(state.packagemembers);
      Map<String, dynamic> formValue =
          Map.of(formMemberKey.currentState?.value ?? {});
      formValue['photopassport'] = memberPhotoPassport;
      formValue['photovaccine'] = memberPhotoVaccine;
      formValue['photortpcr'] = memberPhotoRTPCR;
      User member = User.fromJson(formValue);

      if (packageMember.where((element) => element == member).isEmpty) {
        packageMember.add(member);
      }
      emit(state.copyWith(
          status: DataStatus.success, packagemembers: packageMember));
      AppNavigator.goBack();
    } else {
      if (memberPhotoPassport == null || memberPhotoPassport == "") {
        emit(state.copyWith(
            status: DataStatus.failure,
            error: "Please upload your passport photo"));
      }
    }
  }

  void removeMember({User? member}) {
    emit(state.copyWith(status: DataStatus.loading));
    List<User> listPackageMember = List.of(state.packagemembers);
    listPackageMember.remove(member);
    emit(
      state.copyWith(
          status: DataStatus.success, packagemembers: listPackageMember),
    );
  }

  String getFileString({required FileType fileType}) {
    if (fileType == FileType.passport) {
      return memberPhotoPassport ?? '';
    } else if (fileType == FileType.vaccine) {
      return memberPhotoVaccine ?? '';
    } else if (fileType == FileType.rtpcr) {
      return memberPhotoRTPCR ?? '';
    } else {
      return "";
    }
  }

  Future<void> getImageFile(
      {required ImageSource source, required FileType fileType}) async {
    final XFile? pickFile = await _picker.pickImage(
      source: source,
      imageQuality: 40,
      maxHeight: 200,
      maxWidth: 200,
    );
    if (pickFile != null) {
      File file = File(pickFile.path);
      await uploadFile(file: file, fileType: fileType);
    }
  }

  Future<void> uploadFile(
      {required File file,
      required FileType fileType,
      bool isSelf = false}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _uploadFileUsecase(file);
    result.fold(
        (e) => emit(state.copyWith(status: DataStatus.failure, error: e.msg)),
        (res) {
      if (isSelf == false) {
        if (fileType == FileType.passport) {
          memberPhotoPassport = res.name ?? '';
        } else if (fileType == FileType.vaccine) {
          memberPhotoVaccine = res.name;
        } else if (fileType == FileType.rtpcr) {
          memberPhotoRTPCR = res.name;
        }
        emit(state.copyWith(status: DataStatus.success));
      } else {
        if (fileType == FileType.passport) {
          emit(state.copyWith(
            status: DataStatus.success,
            passportPhoto: res.name,
          ));
        } else if (fileType == FileType.vaccine) {
          emit(state.copyWith(
              status: DataStatus.success, vaccinePhoto: res.name));
        } else if (fileType == FileType.rtpcr) {
          emit(state.copyWith(
            status: DataStatus.success,
            rtpcrPhoto: res.name,
          ));
        }
      }
    });
  }

  Future<void> getImage(
      {required ImageSource source, required FileType type}) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      File file = File(pickedFile.path);
      await uploadFile(file: file, fileType: type, isSelf: true);
    }
  }

  void clearDocument() {
    emit(state.copyWith(
      status: DataStatus.success,
      passportPhoto: null,
      vaccinePhoto: null,
      rtpcrPhoto: null,
    ));
  }

  Future<void> onSvaeDocument() async {
    emit(state.copyWith(status: DataStatus.loading));
    Future.delayed(const Duration(seconds: 2), () {
      List<User> listPackageMember = List.of(state.packagemembers);
      listPackageMember.remove(state.currentUser);

      Map<String, dynamic> userMap = state.currentUser?.toJson() ?? {};
      userMap['photopassport'] = state.passportPhoto;
      userMap['photovaccine'] = state.vaccinePhoto;
      userMap['photortpcr'] = state.rtpcrPhoto;

      User userMember = User.fromJson(userMap);
      listPackageMember.insert(0, userMember);
      print(listPackageMember);
      emit(state.copyWith(
          status: DataStatus.success, packagemembers: listPackageMember));
    });
  }
}
