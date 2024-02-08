import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/features/claim/presentation/pages/request_clain_page.dart';
import 'package:insuranceapp/features/claim/presentation/pages/select_certificate_member_page.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/claim_cubit.dart';

class SelectCertificatePage extends StatelessWidget {
  const SelectCertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClaimCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kSelectCertificate.tr()),
      ),
      body: BlocBuilder<ClaimCubit, ClaimState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: state.listCertificate.map((certificate) {
                  return Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 60,
                          decoration: BoxDecoration(
                            color: Utils.getPaymentColorByStatus(
                                certificate.status!),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Utils.formatDateF(
                                      'dd/MM', certificate.createdtime),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  Utils.formatDateF(
                                      'yyyy', certificate.createdtime),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        title: Text(
                          certificate.no ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${certificate.insurancetype?.name} > ${certificate.insurancepackage?.name}'),
                            Text(certificate.type == 'SINGLE'
                                ? LocaleKeys.kSingle.tr()
                                : LocaleKeys.kFamily.tr()),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 70,
                          child: Column(
                            children: [
                              Text(
                                '${Utils.formatNumber(certificate.amount ?? 0)} ₭',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Utils.getPaymentColorByStatus(
                                      certificate.status!),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Utils.getPaymentColorByStatus(
                                      certificate.status!),
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 1, bottom: 1),
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  certificate.status ?? '',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor:
                                        Utils.getPaymentColorByStatus(
                                            certificate.status ?? ''),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          if (certificate.certificatemember?.length == 1) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<ClaimCubit>.value(
                                value: cubit
                                  ..setCurrentCertificate(certificate)
                                  ..setCerrentMember(
                                      certificate.certificatemember!.first),
                                child: const RequestClaimPage(),
                              ),
                            ));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<ClaimCubit>.value(
                                value: cubit
                                  ..setCurrentCertificate(certificate),
                                child: const SelectCertificateMemberPage(),
                              ),
                            ));
                          }
                        },
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
