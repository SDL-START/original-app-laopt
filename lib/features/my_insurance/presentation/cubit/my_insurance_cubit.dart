import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:pubnub/pubnub.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/entities/webview_params.dart';
import '../../../../core/models/certificate.dart';
import '../../../../core/models/certificate_member.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../home/domain/usecases/get_certificate_member_usecase.dart';
import '../../../home/domain/usecases/get_my_insurance_usecase.dart';
import '../../../home/domain/usecases/pay_bcel_usecase.dart';
import '../../../home/domain/usecases/pay_credit_usecase.dart';

part 'my_insurance_cubit.freezed.dart';
part 'my_insurance_state.dart';

@injectable
class MyInsuranceCubit extends Cubit<MyInsuranceState> {
  final GetMyInsuranceUsecase _getMyInsuranceUsecase;
  final GetCertificateMemberUsecase _certificateMemberUsecase;
  final PayBCELUsecase _payBCELUsecase;
  final PayCreditUsecase _payCreditUsecase;
  MyInsuranceCubit(
    this._getMyInsuranceUsecase,
    this._certificateMemberUsecase,
    this._payBCELUsecase,
    this._payCreditUsecase,
  ) : super(const MyInsuranceState());

  Future<void> getMyInsurance() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getMyInsuranceUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (res) {
      emit(state.copyWith(
        status: DataStatus.success,
        listCertificate: res,
      ));
    });
  }

  Future<void> getCertificateMember({int? id}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _certificateMemberUsecase(id);
    result.fold(
        (er) => emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
        (res) {
      emit(state.copyWith(
          status: DataStatus.success, listCertificateMember: res));
    });
  }

  Future<void> makePayment(
      {required PaymentType type, Certificate? certificate}) async {
    if (type == PaymentType.BCELONE_PAY) {
      final result = await _payBCELUsecase(PayBCELParams(
          id: certificate?.no ?? "0",
          amount: (certificate?.amount == null)
              ? "0"
              : certificate?.amount.toString()));
      result.fold(
          (er) =>
              emit(state.copyWith(status: DataStatus.failure, error: er.msg)),
          (res) async {
        final uuid = UUID(certificate?.no ?? "");

        final pubnub = PubNub(
          defaultKeyset: Keyset(
            subscribeKey: BCELOne.onepaysubscribeKey,
            userId: UserId(uuid.value),
          ),
        );
        var channel = 'mcid-${BCELOne.onepaymcid}-${certificate?.no}';

        final subscription = pubnub.subscribe(
          channels: {channel},
          keyset: Keyset(
            subscribeKey: BCELOne.onepaysubscribeKey,
            userId: UserId(uuid.value),
          ),
        );
        subscription.messages.listen((Envelope envelope) {
          debugPrint('PUBNUB ONMESSAGERECEIVED');
          debugPrint('${envelope.uuid} SENT A MESSAGE: ${envelope.content}');
          final message = jsonDecode(envelope.payload);
          if (message['uuid'] == certificate?.no) {
            // Navigator.pushNamed(context, MyRouter.buysuccess);
          }
        });
        await launchUrl(Uri.parse(res.url ?? ''));
      });
    } else {
      final result =
          await _payCreditUsecase(PayCreditParams(certificate: certificate));
      result.fold((er) => null, (res) {
        AppNavigator.navigateTo(AppRoute.myWebviewRoute,
            params: WebviewParams(
              label: "International payment ",
              url: APIPath.baseUrl + res,
            ));
      });
    }
  }
}
