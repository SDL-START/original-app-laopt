import 'package:freezed_annotation/freezed_annotation.dart';
part 'ticket_action.freezed.dart';
part 'ticket_action.g.dart';
@freezed
class TicketAction with _$TicketAction {
  const factory TicketAction({
    final int? ticketId,
    final int? staffId,
    final double? lat,
    final double? lng,
    final double? acc,
    final String? description,
    final String? status,

  })=_TicketAction;
  factory TicketAction.fromJson(Map<String,dynamic>json)=>_$TicketActionFromJson(json);

}