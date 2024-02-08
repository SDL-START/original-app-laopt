
import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_qr.freezed.dart';
part 'response_qr.g.dart';

@freezed
class Responseqr with _$Responseqr {
  const factory Responseqr({
    String? qrstring,
    String? url,
  })=_Responseqr;

  factory Responseqr.fromJson(Map<String,dynamic>json)=>_$ResponseqrFromJson(json);
}
