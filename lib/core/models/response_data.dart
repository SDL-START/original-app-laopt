import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/claim.dart';

part 'response_data.freezed.dart';
part 'response_data.g.dart';
@freezed
class ResponseData with _$ResponseData{
  const factory ResponseData({
    String? result,
    String? message,
    String? name,
    Claim? claim,
  })=_ResponseData;

  factory ResponseData.fromJson(Map<String,dynamic>json)=>_$ResponseDataFromJson(json);
}