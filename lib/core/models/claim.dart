import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_member.dart';

part 'claim.freezed.dart';
part 'claim.g.dart';
@freezed
class Claim with _$Claim{
  const factory Claim({
    final int? id,
    final DateTime? reqtime,
    final String? status,
    final DateTime? lastupdate,
    final int? certificateId,
    final int? userId,
    final String? employeeId,
    final String? type,
    final double? amount,
    final int? hospitalId,
    final List<String>? photo,
    final DateTime? approveddate,
    final int? approvedby,
    final int? certificatememberId,
    final String? claimMode,
    final Certificate? certificate,
    final CertificateMember? certificatemember,
  })=_Claim;

  factory Claim.fromJson(Map<String,dynamic>json)=>_$ClaimFromJson(json);
}