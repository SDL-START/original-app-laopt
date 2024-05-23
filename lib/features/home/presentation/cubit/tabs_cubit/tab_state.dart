part of 'tab_cubit.dart';

@freezed
class TabState with _$TabState {
  const factory TabState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default(0)
    int currentIndex,

  }) = _Initial;
}
