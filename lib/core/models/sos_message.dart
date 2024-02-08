// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/user.dart';
part 'sos_message.freezed.dart';
part 'sos_message.g.dart';
@freezed
class SOSMessage with _$SOSMessage {
  const factory SOSMessage({
    final int? messageId,
    final int? ticketId,
    final int? senderId,
    final int? reveiverId,
    final String? message,
    final String? image,
    final double? lat,
    final double? lng,
    @JsonKey(name: "message_type")
    final String? messageType,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final bool? isRead,
    final User? sender,
    final User? reveiver,

  })=_SOSMessage;

  factory SOSMessage.fromJson(Map<String, dynamic> json) =>
      _$SOSMessageFromJson(json);
}