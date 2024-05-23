// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:crypto/crypto.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/entities/dropdowns.dart';
import 'package:insuranceapp/core/models/name.dart';
import 'package:insuranceapp/core/models/photo.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/api_path.dart';

enum FlushBarType { SUCCESS, FAIL }

class Utils {
  static String hash({required String value}) {
    final enc = utf8.encode(value);
    final hash = sha512.convert(enc);
    return hash.toString();
  }

  static Future<void> showFlushBar({
    required BuildContext context,
    FlushBarType type = FlushBarType.FAIL,
    String? title,
    String? message,
    Function()? onDismiss,
  }) async {
    await Flushbar(
      padding: const EdgeInsets.all(20),
      flushbarStyle: FlushbarStyle.GROUNDED,
      flushbarPosition: FlushbarPosition.TOP,
      title: title,
      message: message,
      backgroundColor:
          type == FlushBarType.FAIL ? Colors.red : const Color(0xFF303030),
      // leftBarIndicatorColor: Colors.white,

      icon: const Icon(
        Icons.info_outline,
        size: 28.0,
        color: Colors.white,
      ),
      duration: const Duration(seconds: 3),
      mainButton: TextButton(
        onPressed: onDismiss ??
            () {
              Navigator.pop(context);
            },
        child: const Text("Dismiss"),
      ),
    ).show(context);
  }

  static String convertCode({required BuildContext context}) {
    final code = context.locale.languageCode;
    if (code.toLowerCase() == "lo") {
      return "la";
    } else if (code.toLowerCase() == "en") {
      return "us";
    } else {
      return "us";
    }
  }

  static String getTranslate(BuildContext context, Name? name) {
    print(context.locale.languageCode);
    if (context.locale.languageCode == "en") {
      return name?.us ?? '';
    } else if (context.locale.languageCode == "lo") {
      return name?.la ?? "${name?.us}";
    } else {
      return name?.us ?? '';
    }
  }

  static String formatNumber(double? number) {
    if (number == null) return '0';
    return NumberFormat('#,###', 'en_US').format(number);
  }

  static String formatDateF(String? f, String? date) {
    if (date == null) return '';
    return DateFormat(f).format(DateTime.parse(date));
  }

  static String formatDate(String? date) {
    return formatDateF('yyyy-MM-dd', date);
  }

  static String formatDateTime(String? date) {
    if (date == null) return '';
    return formatDateF('yyyy-MM-dd hh:mm:ss', date);
  }

  static Color getPaymentColorByStatus(String status) {
    switch (status) {
      case 'PENDING':
        return Colors.grey.shade400;
      case 'PAID':
      case 'APPROVED':
        return Colors.green.shade600;
      case 'CANCELLED':
        return Colors.red.shade200;
      case 'WAITING':
        return Colors.yellow.shade900;
      default:
        return Colors.black87;
    }
  }

  static Color getSosColorByStatus(String status) {
    switch (status) {
      case 'PENDING':
      case 'WAITING':
        return Colors.yellow.shade900;
      case 'INPROGRESS':
        return Colors.blue.shade500;
      case 'COMPLETED':
        return Colors.green.shade600;
      case 'CANCELED':
        return Colors.red.shade400;
      default:
        return Colors.black87;
    }
  }

  static String formatTime(String? date) {
    return formatDateF('hh:mm:ss', date);
  }

  static Future<void> openUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static double calculateKm(double meters) {
    double km = meters / 1000;
    double roundDistanceInKM = double.parse((km).toStringAsFixed(2));
    return roundDistanceInKM;
  }

  static String onGenerateImageUrl({String? url}) {
    if (url != null) {
      if (url.contains('http')) {
        return url;
      } else {
        return APIPath.publicUrl + url;
      }
    } else {
      return "";
    }
  }

  static Dropdowns? getIntialDropdownValue(
      {dynamic value, List<Dropdowns>? list}) {
    final data = list?.where((e) => e.value == value);
    if (data == null) {
      return null;
    } else if (data.isEmpty) {
      return null;
    } else {
      return data.first;
    }
  }

  static Photo getPhoto({required String val}){
    final jsn = jsonDecode(val);
    Photo photo = Photo.fromJson(jsn);
    return photo;
  }

  static String getProfileUrl({String? value}){
    if(value!=null && value !=""){
      Photo photo = getPhoto(val: value);
      return "${APIPath.publicUrl}${photo.photoprofile}";
    }else{
      return "";
    }
  }
}
