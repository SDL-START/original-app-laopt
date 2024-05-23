// ignore_for_file: non_constant_identifier_names

part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(DataStatus.initial) DataStatus status,
    String? error,
    @Default("en")
    String languageCode,
    User? currentUser,
    User? userProfile,
    @Default([])
    List<Dropdowns> listPurposes,
    @Default([])
    List<Dropdowns> listProvince,
    String? profilePhoto,
    String? vaccinePhoto,
    String? RTPCRPhoto,
    String? passportPhoto,
    String? phoneNumber,
    String? phoneCountry,
    String? purpose,
  }) = _Initial;
}
