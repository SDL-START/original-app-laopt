import 'package:insuranceapp/core/models/certificate.dart';

import '../models/certificate_member.dart';

class PolicyMemberParams {
  final List<CertificateMember> member;
  final Certificate certificate;

  PolicyMemberParams({
    required this.member,
    required this.certificate,
  });
}
