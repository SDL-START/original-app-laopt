import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/user.dart';
part 'sos_info.freezed.dart';
part 'sos_info.g.dart';
@freezed
class SOSInfo with _$SOSInfo {
  const factory SOSInfo({
    final int? id,
    final int? ticketId,
    final int? staffId,
    final double? lat,
    final double? lng,
    final double? acc,
    final String? status,
    final String? description,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final User? user,

  })=_SOSInfo;
    factory SOSInfo.fromJson(Map<String,dynamic>json)=>_$SOSInfoFromJson(json);



}