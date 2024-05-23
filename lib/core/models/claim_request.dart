import 'package:freezed_annotation/freezed_annotation.dart';

part 'claim_request.freezed.dart';
part 'claim_request.g.dart';
@freezed
class ClaimRequest with _$ClaimRequest{
  const factory ClaimRequest({
    double? amount,
    int? hospitalid,
    String? type,
    int? certificateid,
    int? certificatememberid,
    int? userid,
    List<String>? photo,


  })=_ClaimRequest;
  factory ClaimRequest.fromJson(Map<String,dynamic>json)=>_$ClaimRequestFromJson(json);
}