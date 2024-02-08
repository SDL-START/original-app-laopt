import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/network/network_call.dart';
import 'package:insuranceapp/core/services/shared_preferance_service.dart';

import '../models/response_qr.dart';

@injectable
class PaymentService {
  final NetworkCall _networkCall;
  final SharedPreferanceService _pref;
  PaymentService(this._networkCall, this._pref);
  Future<String> creditCard({Certificate? certificate}) async {
    try {
      final user = await _pref.getUser();
      String url = '/payment.html?certificateid=${certificate?.id}';
      url += '&amount=${certificate?.amount}';
      url += '&countrycode=${user.countrycode}';
      url += '&firstname=${user.firstname}';
      url += '&lastname=${user.lastname}';
      url += '&email=${user.email}';
      url += '&phone=${user.phone}';
      url += '&city=${user.city}';
      url += '&address=${user.address}';
      url += '&postal_code=${user.postalcode}';
      url += '&merchant_secure_data1=${certificate?.no}';
      url += '&merchant_secure_data2=${certificate?.type}';
      url += '&merchant_secure_data3=${certificate?.insurancepackage_id}';
      return url;
    } on CacheException catch (er) {
      throw CacheException(er.msg);
    } catch (e) {
      debugPrint(e.toString());
      throw CacheException('UNSUPPORTED_PAYMENT_METHOD');
    }
  }

  Future<Responseqr> bcelOne({required String id, String? amount}) async {
    try {
      final user = await _pref.getUser();
      final res =
          await _networkCall.getGenerateQR(id, amount ?? '0', user.token ?? "");
      return res;
    } catch (er) {
      throw CacheException('UNSUPPORTED_PAYMENT_METHOD');
    }
  }
}
