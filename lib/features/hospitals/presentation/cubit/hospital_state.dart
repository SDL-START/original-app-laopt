part of 'hospital_cubit.dart';

@freezed
class HospitalState with _$HospitalState {
  const factory HospitalState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default([])
    List<Hospital> hospitals,
  
  }) = _Initial;
}
