import 'package:freezed_annotation/freezed_annotation.dart';
 part 'request_sos.freezed.dart';
 part 'request_sos.g.dart';
@freezed
class RequestSOS with _$RequestSOS {
  const factory RequestSOS({
    int? requesterId,
    double? lat,
    double? lng,
    double? acc,
    String? description,
  }) = _RequestSOS;

  factory RequestSOS.fromJson(Map<String,dynamic>json)=>_$RequestSOSFromJson(json);
}
