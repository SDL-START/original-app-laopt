part of 'sos_cubit.dart';

@freezed
class SosState with _$SosState {
  const factory SosState({
    @Default(DataStatus.initial)
    DataStatus status,
    String? error,
    @Default([])
    List<Ticket> listTicket,
    Ticket? ticket,
    User? currentuser,
    LocationData? locationData,
  }) = _Initial;
}
