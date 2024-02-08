
import 'package:freezed_annotation/freezed_annotation.dart';
part 'messages.freezed.dart';
part 'messages.g.dart';
@freezed
class Messages with _$Messages{
  const factory Messages({
    int? ticketId,
    int? senderId,
    int? receiverId,
    String? message,
    DateTime? timestamp,
  })=_Messages;

  factory Messages.fromJson(Map<String,dynamic>json)=>_$MessagesFromJson(json);
}