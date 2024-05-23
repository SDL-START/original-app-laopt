import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/location_log.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/send_message.dart';
import 'package:insuranceapp/core/models/sos_message.dart';
import 'package:insuranceapp/core/models/ticket.dart';

import '../../domain/repositories/support_repository.dart';
import '../datasources/support_remote_datasource.dart';

@LazySingleton(as: SupportRepository)
class SupportRepositoryImpl implements SupportRepository {
  final SupportRemoteDatasource _remoteDatasource;

  SupportRepositoryImpl(this._remoteDatasource);
  @override
  Stream<List<Ticket>> getTicketStream(
      StreamController<List<Ticket>> controller) {
    return _remoteDatasource.getTicketStream(controller);
  }

  @override
  Future<Either<Failure, Ticket>> getTicketInfo({int? ticketId}) async {
    try {
      final ticketInfo =
          await _remoteDatasource.getTicketInfo(ticketId: ticketId);
      return Right(ticketInfo);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Stream<List<SOSMessage>> getMessageStream(
      StreamController<List<SOSMessage>> controller, int? ticketId) {
    return _remoteDatasource.getMessageStream(controller, ticketId);
  }

  @override
  Future<Either<Failure, dynamic>> sendMessage(
      {required SendMessage body}) async {
    try {
      final result = await _remoteDatasource.sendMessage(body: body);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ResponseData>> userCancel(
      {required int ticketId}) async {
    try {
      final result = await _remoteDatasource.userCancel(ticketId: ticketId);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Stream<LocationLog> getLiveLocation(StreamController<LocationLog> controller, int? messageId) {
    return _remoteDatasource.getLocationStream(controller, messageId);
  }
}
