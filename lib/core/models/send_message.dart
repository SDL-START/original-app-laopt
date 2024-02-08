// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'send_message.freezed.dart';
part 'send_message.g.dart';

@freezed
class SendMessage with _$SendMessage {
  const factory SendMessage({
    final int? senderId,
    final int? receiverId,
    final int? ticketId,
    final String? message,
    final double? lat,
    final double? lng,
    final String? image,
    @JsonKey(name: "message_type")
    final String? messageType,
  }) = _SendMessage;

  factory SendMessage.fromJson(Map<String, dynamic> json) =>
      _$SendMessageFromJson(json);
}
