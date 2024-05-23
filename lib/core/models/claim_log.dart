import 'package:freezed_annotation/freezed_annotation.dart';
 part 'claim_log.freezed.dart';
 part 'claim_log.g.dart';
@freezed
class ClaimLog with _$ClaimLog {
  const factory ClaimLog({
    final int? id,
    final DateTime? txtime,
    final String? status,
    final String? remark,
    final int? claimId,
    final int? userId,
    final dynamic requestBody,
  }) = _ClaimLog;
  factory ClaimLog.fromJson(Map<String, dynamic> json) =>
      _$ClaimLogFromJson(json);
}
