import 'package:freezed_annotation/freezed_annotation.dart';
part 'certificate_member.freezed.dart';
part 'certificate_member.g.dart';
@freezed
class CertificateMember with _$CertificateMember {
  const factory CertificateMember({
    int? id,
    String? firstname,
    String? lastname,
    String? relation,
    int? certificate_id,
    String? dob,
    String? gender,
    String? photo,
    String? passport,
    String? countrycode,
    int? province_id,
    String? workplace,
    String? seq,
  }) = _CertificateMember;
  factory CertificateMember.fromJson(Map<String, dynamic> json) =>
      _$CertificateMemberFromJson(json);
}
