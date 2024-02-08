import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';

class PolicyScheduleParams {
  final Certificate certificate;
  final CertificateMember certificateMember;

  PolicyScheduleParams({
    required this.certificate,
    required this.certificateMember,
  });
}
