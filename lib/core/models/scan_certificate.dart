import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';

part 'scan_certificate.freezed.dart';
part 'scan_certificate.g.dart';

@freezed
class ScanCertificate with _$ScanCertificate{
  const factory ScanCertificate({
    Certificate? certificate,
    // ignore: invalid_annotation_target
    @JsonKey(name: "certificate_member")
    CertificateMember? certificateMember,
  }) = _ScanCertificate;

  factory ScanCertificate.fromJson(Map<String,dynamic>json)=>_$ScanCertificateFromJson(json);
}