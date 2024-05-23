import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/ticket.dart';
import '../../../../core/models/ticket_action.dart';

abstract class SOSRepository{
  Future<Either<Failure,List<Ticket>>>getSOSPending();
  Future<Either<Failure,Ticket>>getTicketDetail({required int id});
    Future<Either<Failure,dynamic>>sosRequestActon({required String action,required Map<String,dynamic>data});
  Future<Either<Failure,Ticket>>cancelTicket({required TicketAction action});
  Future<Either<Failure,Ticket>>acceptTicket({required TicketAction action});
  Future<Either<Failure,Ticket>>completeTicket({required TicketAction action});
}