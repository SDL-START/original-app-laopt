import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_response.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/models/claim_log.dart';
import 'package:insuranceapp/core/models/menu.dart';
import 'package:insuranceapp/core/models/response_data.dart';
import 'package:insuranceapp/core/models/response_dropdown.dart';
import 'package:insuranceapp/core/models/response_qr.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/payment_service.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../../../../core/models/certificate_member.dart';
import '../../../../core/models/claim_request.dart';
import '../../../../core/models/pt_image.dart';
import '../../../../core/models/request_sos.dart';
import '../../../../core/models/user.dart';

abstract class HomeRemoteDatasource {
  Future<List<PTImage>> getSlideImage();
  Future<List<Menu>> getMenu();
  Future<ResponseData> uploadFile({required File file});
  Future<CertificateResponse> createCertificate({required Certificate body});
  Future<dynamic> getGenerateQR({required String id, required String amount});
  Future<List<Certificate>> getMyInsurance();
  Future<List<Claim>> getClaim();
  Future<List<ClaimLog>> getClaimLog({required int id});
  Future<List<ResponseDropdown>> getClaimType();
  Future<String> payCredit({Certificate? certificate});
  Future<Responseqr> payBCEL({required String id, String? amount});
  Future<List<Certificate>> getPaidInsurance();
  Future<Ticket> requestSOS({required RequestSOS data});
  Future<dynamic> claimRequest({required ClaimRequest data});
  Future<List<SOSLogs>> getSOSProcessing();
  Future<List<CertificateMember>> getCertificateMember({int? id});
}

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final NetworkCall networkCall;
  final SharedPreferanceService _pref;
  final PaymentService paymentService;

  HomeRemoteDatasourceImpl(this.networkCall, this.paymentService, this._pref);
  @override
  Future<List<PTImage>> getSlideImage() async {
    try {
      final localData = _pref.getSlideImage();
      if (localData != null) {
        return localData;
      } else {
        final res = await networkCall.getSlideImage();
        await _pref.saveSlideImage(listSide: res);
        return res;
      }
    } on DioError catch (er) {
      throw ServerException(er.message);
    }
  }

  Future<User?> getCurrenUser() async {
    try {
      final res = await _pref.getUser();
      return res;
    } catch (er) {
      throw CacheException(er.toString());
    }
  }

  @override
  Future<List<Menu>> getMenu() async {
    try {
      final currentUser = await getCurrenUser();
      final menu = _pref.getMenuLocal();
      if (menu != null) {
        return menu;
      } else {
        final res = await networkCall.getMenu(currentUser?.token ?? '');
        await _pref.saveMenu(menuList: res);
        return res;
      }
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      throw ServerException(e.message);
    } on CacheException catch (er) {
      throw CacheException(er.msg);
    }
  }

  @override
  Future<ResponseData> uploadFile({required File file}) async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.uploadFile(currentUser?.token ?? '', file);
      return res;
      // ignore: deprecated_member_use
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<CertificateResponse> createCertificate(
      {required Certificate body}) async {
    try {
      final currentUser = await getCurrenUser();
      final data = json.encode(body.toJson());
      final res =
          await networkCall.creaetCertificate(currentUser?.token ?? '', data);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<dynamic> getGenerateQR(
      {required String id, required String amount}) async {
    try {
      final currentUser = await getCurrenUser();
      final res =
          await networkCall.getGenerateQR(id, amount, currentUser?.token ?? "");
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<Certificate>> getMyInsurance() async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getMyInsurance(currentUser?.token ?? '');
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<Claim>> getClaim() async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getClaim(currentUser?.token ?? '');
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<ClaimLog>> getClaimLog({required int id}) async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getClaimLog(currentUser?.token ?? '', id);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<ResponseDropdown>> getClaimType() async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getClaimType(currentUser?.token ?? '');
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<String> payCredit({Certificate? certificate}) async {
    try {
      final res = await paymentService.creditCard(certificate: certificate);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<Responseqr> payBCEL({required String id, String? amount}) async {
    try {
      final res = await paymentService.bcelOne(id: id, amount: amount);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<Certificate>> getPaidInsurance() async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getPaidInsurance(currentUser?.token ?? '');
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<Ticket> requestSOS({required RequestSOS data}) async {
    try {
      final currentUser = await getCurrenUser();
      final res =
          await networkCall.requestSOS(currentUser?.token ?? '', data.toJson());
      return res;
    } on DioError catch (er) {
      throw ServerException(er.response?.data['message']);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future claimRequest({required ClaimRequest data}) async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.claimRequest(
          currentUser?.token ?? '', data.toJson());
      return res;
    } on DioError catch (er) {
      throw ServerException(er.response?.data['message']);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<SOSLogs>> getSOSProcessing() async {
    try {
      final currentUser = await getCurrenUser();
      final res = await networkCall.getSOSProcessing(
          currentUser?.token ?? '', currentUser?.id ?? 0);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }

  @override
  Future<List<CertificateMember>> getCertificateMember({int? id}) async {
    try {
      final currentUser = await getCurrenUser();
      final res =
          await networkCall.getCertificateMember(currentUser?.token ?? '', id);
      return res;
    } on DioError catch (er) {
      throw ServerException(er.message);
    } on CacheException catch (e) {
      throw CacheException(e.msg);
    }
  }
}
