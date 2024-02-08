import 'package:freezed_annotation/freezed_annotation.dart';
part 'one_pay_qr.freezed.dart';
part 'one_pay_qr.g.dart';
@freezed
class OnePayQR with _$OnePayQR {
  const factory OnePayQR({
    String? id,
    String? amount,
    String? paycode,
    String? uuid,
    String? mcid,
    String? fccref,
    String? phone,
  }) = _OnePayQR;

  factory OnePayQR.fromJson(Map<String,dynamic>json)=>_$OnePayQRFromJson(json);
}
