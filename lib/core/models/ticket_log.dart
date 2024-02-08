// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/user.dart';
 part 'ticket_log.freezed.dart';
 part 'ticket_log.g.dart';

@freezed
class TicketLog with _$TicketLog {
  const factory TicketLog({
    int? id,
    int? ticket_id,
    int? userid,
    DateTime? confirm_date,
    String? description,
    String? status,
    String? lat,
    String? lng,
    String? acc,
    User? user,
    Ticket? sos_tickets,
  }) = _TicketLog;

  factory TicketLog.fromJson(Map<String, dynamic> json) =>
      _$TicketLogFromJson(json);
}
