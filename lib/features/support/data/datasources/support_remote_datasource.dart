import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/sos_message.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/location_log.dart';
import '../../../../core/models/send_message.dart';

abstract class SupportRemoteDatasource {
  Stream<List<Ticket>> getTicketStream(
      StreamController<List<Ticket>> controller);
  Future<Ticket> getTicketInfo({int? ticketId});
  Future<dynamic> sendMessage({required SendMessage body});

  Stream<List<SOSMessage>> getMessageStream(
      StreamController<List<SOSMessage>> controller, int? ticketId);
  Future<ResponseData> userCancel({required int ticketId});

  Stream<LocationLog>getLocationStream(StreamController<LocationLog>controller,int? messageId);
}

@LazySingleton(as: SupportRemoteDatasource)
class SupportRemoteDatasourceImpl implements SupportRemoteDatasource {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;
  SupportRemoteDatasourceImpl(this._networkCall, this._pref);

  @override
  Stream<List<Ticket>> getTicketStream(
      StreamController<List<Ticket>> controller) async* {
    _pref.getUser().then((user) async {
      while (!controller.isClosed) {
        await Future.delayed(const Duration(seconds: 2), () async {
          List<Ticket>? listTicket;
          if (user.role == "STAFF") {
            listTicket = await _networkCall.getTicketStaff(
                user.token ?? '', user.id ?? 0);
          } else {
            listTicket = await _networkCall.getTicketHistories(
                user.token ?? '', user.id ?? 0);
          }
          if (!controller.isClosed) {
            controller.add(listTicket);
          }
          print("#### Get Stream ticket ${listTicket.length}");
        });
      }
    });
    yield* controller.stream;
  }

  @override
  Future<Ticket> getTicketInfo({int? ticketId}) async {
    try {
      final user = await _pref.getUser();
      final ticketInfo =
          await _networkCall.getTicketInfo(user.token ?? '', ticketId ?? 0);
      return ticketInfo;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<List<SOSMessage>> getMessageStream(
      StreamController<List<SOSMessage>> controller, int? ticketId) async* {
    _pref.getUser().then((user) async {
      while (!controller.isClosed) {
        await Future.delayed(const Duration(seconds: 5), () async {
          final List<SOSMessage> messages =
              await _networkCall.getMessage(user.token ?? '', ticketId ?? 0);
          if (!controller.isClosed) {
            controller.add(messages);
          }
          print("### Stream message $messages");
        });
      }
    });
    yield* controller.stream;
  }

  @override
  Future<dynamic> sendMessage({required SendMessage body}) async {
    try {
      final user = await _pref.getUserToken();
      return await _networkCall.sendMessage(
          user ?? '', jsonEncode(body.toJson()));
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      print(e);
      throw ServerException(e.toString());
    }
  }

  @override
  Future<ResponseData> userCancel({required int ticketId}) async {
    try {
      final token = await _pref.getUserToken() ?? "";
      return await _networkCall.userCancel(token, ticketId);
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Stream<LocationLog> getLocationStream(StreamController<LocationLog> controller, int? messageId) async*{
    _pref.getUser().then((user) async {
      while (!controller.isClosed) {
        await Future.delayed(const Duration(seconds: 5), () async {
          final LocationLog locationLog = await _networkCall.getLiveLocation(user.token??'', messageId??0);
          if (!controller.isClosed) {
            controller.add(locationLog);
          }
          print("### Stream location $locationLog");
        });
      }
    });
    yield* controller.stream;
  }
}
