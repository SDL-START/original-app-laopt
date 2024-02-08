import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';
import 'package:insuranceapp/core/models/insurance.dart';
import 'package:insuranceapp/core/models/insurance_package.dart';
import 'package:insuranceapp/core/models/user.dart';
part 'certificate.freezed.dart';
part 'certificate.g.dart';

@freezed
class Certificate with _$Certificate {
  const factory Certificate({
    double? amount,
    int? typeid,
    int? packageid,
    int? userid,
    @Default([]) List<User?> members,
    String? type,
    int? id,
    String? no,
    String? createdtime,
    int? employee_id,
    int? insurancetype_id,
    int? insurancepackage_id,
    String? status,
    int? servicelocation_id,
    String? buy_mode,
    String? expirytime,
    InsurancePackage? insurancepackage,
    Insurance? insurancetype,
    User? user,
    List<CertificateMember>? certificatemember,
  }) = _Certificate;

  factory Certificate.fromJson(Map<String, dynamic> json) =>
      _$CertificateFromJson(json);
}
