import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/core/widgets/pt_custom_button.dart';
import 'package:insuranceapp/features/home/presentation/widgets/detail_item.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import '../../../../core/params/policy_member_params.dart';
import '../../../../core/params/policy_schedule_params.dart';
import '../cubit/my_insurance_cubit.dart';

class MyInsuranceDetailPage extends StatelessWidget {
  final Certificate certificate;
  const MyInsuranceDetailPage({super.key, required this.certificate});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyInsuranceCubit, MyInsuranceState>(
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kMyInsurance.tr()),
            actions: [
              TextButton(
                onPressed: () {
                  AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
                },
                child: Text(
                  LocaleKeys.kCancel.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              if (state.listCertificateMember.length > 1) {
                AppNavigator.navigateTo(
                  AppRoute.certificateMemberRoute,
                  params: PolicyMemberParams(
                    certificate: certificate,
                    member: state.listCertificateMember,
                  ),
                );
              } else {
                AppNavigator.navigateTo(
                  AppRoute.policySchedule,
                  params: PolicyScheduleParams(
                    certificate: certificate,
                    certificateMember: state.listCertificateMember.first,
                  ),
                );
              }
            },
            label: Text(LocaleKeys.kPolicySchedule.tr()),
            icon: const Icon(Icons.list_alt),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: SfBarcodeGenerator(
                        value: certificate.no,
                        textAlign: TextAlign.center,
                        showValue: true,
                        textSpacing: 4,
                        symbology: QRCode(),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    padding: const EdgeInsets.only(top: 8),
                    child: Center(
                      child: SfBarcodeGenerator(
                        value: certificate.no,
                        textAlign: TextAlign.center,
                        symbology: Code128(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Center(
                      child: Text(certificate.no!),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        DetailItem(
                          label: LocaleKeys.kCreateDate.tr(),
                          value: Utils.formatDateTime(certificate.createdtime),
                        ),
                        DetailItem(
                            label: LocaleKeys.kProduct.tr(),
                            value: certificate.insurancetype?.name),
                        DetailItem(
                            label: LocaleKeys.kPackage.tr(),
                            value: certificate.insurancepackage?.name),
                        DetailItem(
                            label: LocaleKeys.kType.tr(),
                            value:
                                "${certificate.type} ${certificate.members.length}"),
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: DetailItem(
                                    label: LocaleKeys.kAmount.tr(),
                                    value:
                                        Utils.formatNumber(certificate.amount)),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Utils.getPaymentColorByStatus(
                                          certificate.status ?? ''),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: SizedBox(
                                    height: 60,
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          LocaleKeys.kStatus.tr(),
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          certificate.status ?? '',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (certificate.status == 'PENDING')
                          PTCustomButton(
                            label: "PAY",
                            onTap: () {
                              AppNavigator.navigateTo(
                                AppRoute.paymentRoute,
                                params: certificate,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    color: Colors.grey.shade200,
                    child: Text(
                      LocaleKeys.kMember.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: state.listCertificateMember.length,
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemBuilder: (context, index) {
                        final member = state.listCertificateMember[index];
                        return ListTile(
                          leading: Container(
                            child: index == 0
                                ? const Icon(
                                    Icons.account_circle_outlined,
                                    size: 42,
                                  )
                                : const Icon(
                                    Icons.supervised_user_circle_outlined,
                                    size: 42,
                                  ),
                          ),
                          title: Row(
                            children: [
                              Text(
                                '${member.firstname} ${member.lastname}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          isThreeLine: true,
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(Utils.formatDate(member.dob)),
                              Text(member.passport ?? ''),
                            ],
                          ),
                          trailing: (certificate.certificatemember != null &&
                                  certificate.certificatemember!.length < 2)
                              ? const SizedBox.shrink()
                              : Container(
                                  padding: const EdgeInsets.only(
                                      left: 8, right: 8, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.red,
                                  ),
                                  child: Text(
                                    member.relation ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
