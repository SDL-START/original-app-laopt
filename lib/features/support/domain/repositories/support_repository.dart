import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/sos_message.dart';
import 'package:insuranceapp/core/models/ticket.dart';

import '../../../../core/models/location_log.dart';
import '../../../../core/models/send_message.dart';

abstract class SupportRepository {
  Stream<List<Ticket>> getTicketStream(
      StreamController<List<Ticket>> controller);
  Future<Either<Failure, Ticket>> getTicketInfo({int? ticketId});
  Stream<List<SOSMessage>> getMessageStream(
      StreamController<List<SOSMessage>> controller, int? ticketId);
  Future<Either<Failure, dynamic>> sendMessage({required SendMessage body});
  Future<Either<Failure,ResponseData>>userCancel({required int ticketId});

  Stream<LocationLog>getLiveLocation(StreamController<LocationLog> controller,int? messageId);
}
