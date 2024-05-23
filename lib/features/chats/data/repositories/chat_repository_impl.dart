import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/ticket_log.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/chats/data/datasources/chat_remote_datasource.dart';
import 'package:insuranceapp/features/chats/domain/repositories/chat_repository.dart';

@LazySingleton(as: ChatRepository)
class ChatrepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _chatRemoteDatasource;

  ChatrepositoryImpl(this._chatRemoteDatasource);

  @override
  Future<Either<Failure, List<Ticket>>> getTicketHistories() async {
    try {
      final res = await _chatRemoteDatasource.getTicketHistories();
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    } on CacheException catch (er) {
      return Left(CacheFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, TicketLog>> getTicketDetail(
      {required int id, required String status}) async {
    try {
      final res =
          await _chatRemoteDatasource.getTicketDetail(id: id, status: status);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    } on CacheException catch (er) {
      return Left(CacheFailure(er.msg));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required int id}) async {
    try {
      final res = await _chatRemoteDatasource.getUserById(id: id);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    } catch (er) {
      return Left(CacheFailure(er.toString()));
    }
  }
}
