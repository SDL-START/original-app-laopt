part of 'home_cubit.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(DataStatus.initial) DataStatus status,
    String? error,
    User? currentUser,
    List<PTImage>? listSlideImage,
    List<Menu>? listMenu,
    LocationData? currentLocation,
    String? message,
  }) = _Initial;
}
