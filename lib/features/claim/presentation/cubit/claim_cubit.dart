import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/models/user.dart';

import '../../../../core/models/certificate.dart';
import '../../../../core/models/certificate_member.dart';
import '../../../../core/models/claim.dart';
import '../../../../core/models/claim_log.dart';
import '../../../../core/models/claim_request.dart';
import '../../../../core/models/response_dropdown.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../home/domain/usecases/claim_request_usecase.dart';
import '../../../home/domain/usecases/get_claim_log_usecase.dart';
import '../../../home/domain/usecases/get_claim_type_usecase.dart';
import '../../../home/domain/usecases/get_claim_usecase.dart';
import '../../../home/domain/usecases/get_paid_insurance_usecase.dart';
import '../../../home/domain/usecases/upload_file_usecase.dart';
import '../../../login/domain/usecases/get_hospital_usecase.dart';

part 'claim_cubit.freezed.dart';
part 'claim_state.dart';

@injectable
class ClaimCubit extends Cubit<ClaimState> {
  final GetClaimUsecase _getClaimUsecase;
  final GetPaidInsuranceUsecase _getPaidInsuranceUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final GetHospitalUsecase _getHospitalUsecase;
  final GetClaimTypeUsecase _getClaimTypeUsecase;
  final UploadFileUsecase _uploadFileUsecase;
  final ClaimRequestUsecase _claimRequestUsecase;
  final GetClaimLogUsecase _getClaimLogUsecase;
  ClaimCubit(
    this._getClaimUsecase,
    this._getPaidInsuranceUsecase,
    this._getUserLocalUsecase,
    this._getHospitalUsecase,
    this._getClaimTypeUsecase,
    this._uploadFileUsecase,
    this._claimRequestUsecase,
    this._getClaimLogUsecase,
  ) : super(const ClaimState());
  GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  Future<void> getCurrentUser() async {
    final currentUser =  _getUserLocalUsecase(NoParams());
    emit(state.copyWith(currentUser: currentUser));
  }

  Future<void> getHospital() async {
    final result = await _getHospitalUsecase(NoParams());
    result.fold((er) {
      emit(state.copyWith(status: DataStatus.failure, error: er.msg));
    }, (listHospital) {
      emit(state.copyWith(listHospital: listHospital));
    });
  }

  Future<void> getClaimType() async {
    final result = await _getClaimTypeUsecase(NoParams());
    result.fold((er) {
      emit(state.copyWith(status: DataStatus.failure, error: er.msg));
    }, (claimType) {
      emit(state.copyWith(listClaimType: claimType));
    });
  }

  Future<void> getCliam() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getClaimUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (listClaim) {
      emit(
        state.copyWith(status: DataStatus.initial, listClaim: listClaim),
      );
    });
  }

  Future<void> getPaidInsurance() async {
    emit(state.copyWith(status: DataStatus.loading));
    final resutl = await _getPaidInsuranceUsecase(NoParams());
    resutl.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (listCertificate) {
      emit(state.copyWith(
        status: DataStatus.loaded,
        listCertificate: listCertificate,
      ));
    });
  }

  void setCurrentCertificate(Certificate certificate) {
    emit(state.copyWith(
      currentCertificate: certificate,
      status: DataStatus.initial,
    ));
  }

  void setCerrentMember(CertificateMember member) {
    emit(
      state.copyWith(
        status: DataStatus.initial,
        currentCertificateMember: member,
      ),
    );
  }

  void onSaveAndValidate() {
    final formValue =
        Map<String, dynamic>.of(formKey.currentState?.value ?? {});
    emit(state.copyWith(formValue: formValue));
  }

  Future<void> getImage({required ImageSource source}) async {
    final imagePicker = ImagePicker();
    final pickFile = await imagePicker.pickImage(
      source: source,
      imageQuality: 40,
      maxWidth: 200,
      maxHeight: 200,
    );
    if (pickFile != null) {
      File file = File(pickFile.path);
      await uploadDocuments(file: file);
    }
  }

  Future<void> uploadDocuments({required File file}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _uploadFileUsecase(file);
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (data) {
      List<String> listImage = List.of(state.listDocument);
      if (data.name != null) {
        listImage.add(data.name!);
      }
      emit(state.copyWith(status: DataStatus.success, listDocument: listImage));
    });
  }

  Future<void> onRequestClaim() async {
    emit(state.copyWith(status: DataStatus.loading));
    Map<String, dynamic> formRequestValue = Map.of(state.formValue);
    formRequestValue['userid'] = state.currentUser?.id;
    formRequestValue['photo'] = state.listDocument;
    formRequestValue['certificateid'] = state.currentCertificate?.id;
    formRequestValue['certificatememberid'] =
        state.currentCertificateMember?.id;
    ClaimRequest claim = ClaimRequest.fromJson(formRequestValue);
    final result = await _claimRequestUsecase(claim);
    result.fold((er) {
      emit(state.copyWith(status: DataStatus.failure, error: er.msg));
    }, (res) {
      AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
    });
  }

  Future<void> getClaimLog({required int id}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getClaimLogUsecase(GetClaimLogParams(id: id));
    result.fold(
        (er) =>
            emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (listClaimLog) {
      emit(state.copyWith(status: DataStatus.success, listClaimLog: listClaimLog));
    });
  }
}
