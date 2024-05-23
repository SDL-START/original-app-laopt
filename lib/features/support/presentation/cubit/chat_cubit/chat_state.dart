part of 'chat_cubit.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState({
    @Default(DataStatus.initial) final DataStatus status,
    final String?  error,
    final User? currentUser,
    final List<SOSMessage>? listMessage,
    final Ticket? ticket,
    @Default(false)
    final bool canSend,
    final LocationData? currentLocation,
    final double? distance,
  }) = _Initial;
}
