// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_log.freezed.dart';
part 'location_log.g.dart';

@freezed
class LocationLog with _$LocationLog {
  const factory LocationLog({
    final int? id,
    final int? messageId,
    final double? lat,
    final double? lng,
    @JsonKey(name: "created_at") final DateTime? createdAt,
    @JsonKey(name: "updated_at") final DateTime? updatedAt,
  }) = _LocationLog;

  factory LocationLog.fromJson(Map<String, dynamic> json) =>
      _$LocationLogFromJson(json);
}
