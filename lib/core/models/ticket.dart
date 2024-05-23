// ignore_for_file: non_constant_identifier_names, invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/sos_info.dart';
import 'package:insuranceapp/core/models/user.dart';

part 'ticket.freezed.dart';
part 'ticket.g.dart';
@freezed
class Ticket with _$Ticket{
  const factory Ticket({
    final int? ticketId,
    final int? requesterId,
    final int? accepter,
    final double? lat,
    final double? lng,
    final double? acc,
    final String? status,
    final DateTime? createdAt,
    final DateTime? updatedAt,
    final String? description,
    final User? user,
    @JsonKey(name: "sos_info")
    final SOSInfo? sosInfo,
  })=_Ticket;

  factory Ticket.fromJson(Map<String,dynamic>json)=>_$TicketFromJson(json);
  
}