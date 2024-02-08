part of 'location_cubit.dart';

@freezed
class LocationState with _$LocationState {
  const factory LocationState({
    @Default(DataStatus.initial)
    final DataStatus status,
    final String? error,
    final LocationLog? locationLog,
    final LocationData? currentLocation,
  })= _Initial;
}
