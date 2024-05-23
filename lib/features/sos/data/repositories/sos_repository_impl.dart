import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/ticket.dart';

import 'package:insuranceapp/core/error/failures.dart';

import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/ticket_action.dart';
import 'package:insuranceapp/features/sos/data/datasources/sos_remote_datasource.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/sos_repository.dart';

@LazySingleton(as: SOSRepository)
class SOSRepositoryImpl implements SOSRepository {
  final SOSRemoteDatasource _sosRemoteDatasource;

  SOSRepositoryImpl(this._sosRemoteDatasource);
  @override
  Future<Either<Failure, List<Ticket>>> getSOSPending() async {
    try {
      final res = await _sosRemoteDatasource.getSOSPending();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Ticket>> getTicketDetail({required int id}) async {
    try {
      final res = await _sosRemoteDatasource.getTicketDetail(id: id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, dynamic>> sosRequestActon(
      {required String action, required Map<String, dynamic> data}) async {
    try {
      final res = await _sosRemoteDatasource.sosRequestAction(
          action: action, data: data);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, Ticket>> cancelTicket(
      {required TicketAction action}) async {
    try {
      return Right(await _sosRemoteDatasource.cancelTicket(action: action));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Ticket>> acceptTicket(
      {required TicketAction action}) async {
    try {
      return Right(await _sosRemoteDatasource.acceptTicket(action: action));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Ticket>> completeTicket(
      {required TicketAction action}) async {
    try {
      return Right(await _sosRemoteDatasource.completeTicket(action: action));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
