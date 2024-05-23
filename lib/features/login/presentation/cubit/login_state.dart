part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    PackageInfo? packageInfo,
    String? firebaseToken,
    @Default(true)
    bool rememberMe,
    LoginData? loginData,
    Country? initialCountry,
    @Default(ValidateType.PHONE)
    ValidateType forgotType,
    @Default(true)
    bool validated,
    User? requestData,
  }) = _Initial;
}
