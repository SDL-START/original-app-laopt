import 'dart:async';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/messages.dart';
import 'package:insuranceapp/core/models/ticket_log.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/ticket.dart';
import '../../../../core/services/firebase_services.dart';

abstract class ChatRemoteDatasource {
  Future<List<Ticket>> getTicketHistories();
  Future<TicketLog> getTicketDetail({required int id, required String status});
  Stream<List<Messages>> getReceiveMessage(
      StreamController<List<Messages>> controller);
  Future<User> getUserById({required int id});
}

@LazySingleton(as: ChatRemoteDatasource)
class ChatRemoteDatasourceImpl implements ChatRemoteDatasource {
  final NetworkCall _networkCall;
  final FirebaseServices _firebaseServices;
  final SharedPreferanceService _pref;

  ChatRemoteDatasourceImpl(
      this._networkCall, this._firebaseServices, this._pref);

  @override
  Future<List<Ticket>> getTicketHistories() async {
    try {
      final user = await _pref.getUser();
      final res =
          await _networkCall.getTicketHistories(user.token ?? '', user.id ?? 0);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (er) {
      throw CacheException(er.msg);
    } catch (e) {
      print("unknow exception $e");
      throw CacheException(e.toString());
    }
  }

  @override
  Future<TicketLog> getTicketDetail(
      {required int id, required String status}) async {
    try {
      final user = await _pref.getUser();
      final res =
          await _networkCall.getTicketDetail(user.token ?? '', id, status);
      return res;
    // ignore: deprecated_member_use
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (er) {
      throw CacheException(er.msg);
    } catch (e) {
      print("unknow exception $e");
      throw CacheException(e.toString());
    }
  }

  @override
  Stream<List<Messages>> getReceiveMessage(
      StreamController<List<Messages>> controller) {
    final res = _firebaseServices.receiveMessage(collection: 'Messages');
    List<Messages> listMessage = [];
    res.asBroadcastStream(
      onListen: (subscription) {
        subscription.onData((data) {});
      },
    );
    if (!controller.isClosed) {
      controller.add(listMessage);
    }
    return controller.stream;
  }

  @override
  Future<User> getUserById({required int id}) async {
    try {
      final currentUser = await _pref.getUser();
      final data = await _networkCall.getUserById(currentUser.token ?? '', id);
      return data;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } catch (er) {
      throw CacheException(er.toString());
    }
  }
}
