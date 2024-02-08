import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/user.dart';

import '../../../../core/models/ticket_log.dart';

abstract class ChatRepository{
  Future<Either<Failure,List<Ticket>>>getTicketHistories();
  Future<Either<Failure,TicketLog>>getTicketDetail({required int id,required String status});
  Future<Either<Failure,User>>getUserById({required int id});
}