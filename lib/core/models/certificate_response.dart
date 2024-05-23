import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/certificate.dart';
part 'certificate_response.freezed.dart';
part 'certificate_response.g.dart';
@freezed
class CertificateResponse with _$CertificateResponse {
  const factory CertificateResponse({
    String? result,
    String? message,
    Certificate? certificate,
  }) = _CertificateResponse;

  factory CertificateResponse.fromJson(Map<String,dynamic>json)=>_$CertificateResponseFromJson(json);
}
