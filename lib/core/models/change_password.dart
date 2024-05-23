
import 'package:freezed_annotation/freezed_annotation.dart';
part 'change_password.freezed.dart';
part 'change_password.g.dart';
@freezed
class ChangePassword with _$ChangePassword{
  const factory ChangePassword({
    String? currentPassword,
    String? newPassword,
    String? confirmPassword,
    int? userid,
  })=_ChangePassword;

  factory ChangePassword.fromJson(Map<String,dynamic>json)=>_$ChangePasswordFromJson(json);
}