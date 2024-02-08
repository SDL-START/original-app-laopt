part of 'support_cubit.dart';

@freezed
class SupportState with _$SupportState {
  const factory SupportState({
    @Default(DataStatus.initial) 
    final DataStatus status,
    final String? error,
    @Default([]) List<Ticket>? listTicket,
    final Ticket? ticket,
    final User? currentUser,
  }) = _Initial;
}
