import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/models/certificate.dart';
import '../../../../core/utils/utils.dart';

class PolicySchedulePage extends StatelessWidget {
  final Certificate certificate;
  final CertificateMember certificateMember;
  const PolicySchedulePage({
    super.key,
    required this.certificate,
    required this.certificateMember,
  });

  @override
  Widget build(BuildContext context) {
    final String url =
        "${APIPath.baseUrl}/policyschedule?id=${certificate.id}&no=${certificate.no}&member=${certificateMember.seq}&lang=${Utils.convertCode(context: context)}";
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.kPolicySchedule.tr(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: InAppWebView(
          onProgressChanged: (controller, progress) {
            // print(progress);
          },
          initialUrlRequest: URLRequest(url: Uri.parse(url)),
        ),
      ),
    );
  }
}
