part of 'app_cubit.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    DataStatus? status,
    String? error,
    @Default(false)
    bool isAuth,
    final VersionStatus? versionStatus,
  }) = _Initial;
}
