import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/ticket.dart';
import '../../../../core/models/ticket_action.dart';

abstract class SOSRemoteDatasource {
  Future<List<Ticket>> getSOSPending();
  Future<Ticket> getTicketDetail({required int id});
  Future<dynamic> sosRequestAction(
      {required String action, required Map<String, dynamic> data});
  Future<Ticket> cancelTicket({required TicketAction action});
  Future<Ticket> acceptTicket({required TicketAction action});
  Future<Ticket> completeTicket({required TicketAction action});
}

@LazySingleton(as: SOSRemoteDatasource)
class SOSRemoteDatasourceImpl implements SOSRemoteDatasource {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;

  SOSRemoteDatasourceImpl(
    this._networkCall,
    this._pref,
  );
  @override
  Future<List<Ticket>> getSOSPending() async {
    try {
      final String? token = await _pref.getUserToken();
      final data = await _networkCall.getSOSPending(token ?? '');
      return data;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<Ticket> getTicketDetail({required int id}) async {
    try {
      final String? token = await _pref.getUserToken();
      final res = await _networkCall.getTicketInfo(token ?? '', id);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future sosRequestAction(
      {required String action, required Map<String, dynamic> data}) async {
    try {
      final String? token = await _pref.getUserToken();
      final res =
          await _networkCall.sosRequestAction(token ?? '', action, data);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<Ticket> cancelTicket({required TicketAction action}) async {
    try {
      final String token = await _pref.getUserToken() ?? '';
      final result = await _networkCall.cancelTicket(
        token,
        jsonEncode(action.toJson()),
      );
      return result;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Ticket> acceptTicket({required TicketAction action}) async {
    try {
      final String token = await _pref.getUserToken() ?? '';
      final result = await _networkCall.acceptTicket(
        token,
        jsonEncode(action.toJson()),
      );
      return result;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Ticket> completeTicket({required TicketAction action}) async {
    try {
      final String token = await _pref.getUserToken() ?? '';
      final result = await _networkCall.completeTicket(
        token,
        jsonEncode(action.toJson()),
      );
      return result;
    } on DioError catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
