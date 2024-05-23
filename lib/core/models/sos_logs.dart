import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/ticket.dart';
part 'sos_logs.freezed.dart';
part 'sos_logs.g.dart';
@freezed
class SOSLogs with _$SOSLogs {
  const factory SOSLogs({
    int? id,
    int? ticket_id,
    int? userid,
    DateTime? confirm_date,
    String? description,
    String? status,
    Ticket? sos_tickets,
  }) = _SOSLogs;

  factory SOSLogs.fromJson(Map<String,dynamic>json)=>_$SOSLogsFromJson(json);
}
