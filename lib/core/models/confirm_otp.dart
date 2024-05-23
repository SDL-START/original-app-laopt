
import 'package:freezed_annotation/freezed_annotation.dart';
 part 'confirm_otp.freezed.dart';
 part 'confirm_otp.g.dart';
@freezed
class ConfirmOTP with _$ConfirmOTP {
  const factory ConfirmOTP({
    String? email,
    String? phone,
    String? type,
    String? otp,
  }) = _ConfirmOTP;

  factory ConfirmOTP.fromJson(Map<String, dynamic> json) =>
      _$ConfirmOTPFromJson(json);
}
