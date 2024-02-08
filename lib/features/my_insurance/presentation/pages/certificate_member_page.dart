import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../../core/models/certificate_member.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../core/params/policy_schedule_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';

class CertificateMemberPage extends StatelessWidget {
  final List<CertificateMember> member;
  final Certificate certificate;
  const CertificateMemberPage({
    super.key,
    this.member = const [],
    required this.certificate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.kSelectCertificateMember.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: member.map((member) {
              return Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                    ),
                    title: Text("${member.firstname} ${member.lastname}"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Text(Utils.formatDate(member.dob)),
                        const SizedBox(height: 5),
                        Text("${member.passport}"),
                      ],
                    ),
                    onTap: () {
                      AppNavigator.navigateTo(
                        AppRoute.policySchedule,
                        params: PolicyScheduleParams(
                          certificate: certificate,
                          certificateMember: member,
                        ),
                      );
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
