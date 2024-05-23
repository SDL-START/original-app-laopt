part of 'language_cubit.dart';

@freezed
class LanguageState with _$LanguageState {
  const factory LanguageState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    String? langCode,
  }) = _Initial;
}
