import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_data.freezed.dart';
part 'login_data.g.dart';

@freezed
class LoginData with _$LoginData{
  const factory LoginData({
    String? phoneNumber,
    String? codeNumber,
    String? codeString,
    String? email,
  }) = _LoginData;
  factory LoginData.fromJson(Map<String,dynamic>json)=>_$LoginDataFromJson(json);
}