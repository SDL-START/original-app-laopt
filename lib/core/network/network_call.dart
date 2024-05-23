import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_response.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/models/claim_log.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/models/insurance.dart';
import 'package:insuranceapp/core/models/insurance_package.dart';
import 'package:insuranceapp/core/models/menu.dart';
import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/models/purpose.dart';
import 'package:insuranceapp/core/models/response_dropdown.dart';
import 'package:insuranceapp/core/models/scan_certificate.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/models/sos_message.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:retrofit/retrofit.dart';

import '../constants/api_path.dart';
import '../models/certificate_member.dart';
import '../models/languages.dart';
import '../models/location_log.dart';
import '../models/pt_image.dart';
import '../models/response_data.dart';
import '../models/response_qr.dart';
import '../models/ticket_log.dart';
import '../models/translations.dart';

part 'network_call.g.dart';

@RestApi()
@singleton
abstract class NetworkCall {
  @factoryMethod
  factory NetworkCall(Dio dio) = _NetworkCall;

  @POST(APIPath.loginUrl)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<User> login(@Body() dynamic body);

  @GET(APIPath.getLang)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Languages>> getLanguage();

  @GET(APIPath.getTranslate)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Translations>> getTranslation();

  @GET("${APIPath.getTranslateJson}/{code}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<dynamic> getTranslateJson(@Path('code') String code);

  @POST(APIPath.postChangePassword)
  @Headers(<String, dynamic>{
    "Content-Type": "application/json",
  })
  Future<ResponseData> changePassword(
      @Header("Authorization") String token, @Body() dynamic body);

  @GET(APIPath.getSlideImage)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<PTImage>> getSlideImage();

  @GET(APIPath.getMenu)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Menu>> getMenu(@Header("Authorization") String token);

  @GET(APIPath.getHospital)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Hospital>> getHospital();

  @GET(APIPath.getInsuranceType)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Insurance>> getInsuranceType(
      @Header("Authorization") String token);

  @GET("${APIPath.getInsurancePackage}/{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<InsurancePackage>> getInsurancePackage(
      @Header("Authorization") String token, @Path('id') int id);

  @POST(APIPath.upload)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> uploadFile(@Header("Authorization") String token,
      @Part(name: 'filetoupload') File file);

  @POST(APIPath.createCertificate)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<CertificateResponse> creaetCertificate(
      @Header("Authorization") String token, @Body() dynamic body);

  @GET("${APIPath.generateQr}/{id}/{amount}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Responseqr> getGenerateQR(@Path('id') String id,
      @Path('amount') String amount, @Header("Authorization") String token);

  @GET(APIPath.getInsurance)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Certificate>> getMyInsurance(
      @Header("Authorization") String token);

  @GET(APIPath.getClaim)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Claim>> getClaim(@Header("Authorization") String token);

  @GET("${APIPath.getClaimLog}/{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<ClaimLog>> getClaimLog(
      @Header("Authorization") String token, @Path('id') int id);

  @GET(APIPath.getClaimType)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<ResponseDropdown>> getClaimType(
      @Header("Authorization") String token);

  @GET(APIPath.getPaidInsurance)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Certificate>> getPaidInsurance(
      @Header("Authorization") String token);

  @GET(APIPath.getHospitalServcie)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Hospital>> getHospitalService();

  @GET("${APIPath.ticketHistories}={id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Ticket>> getTicketHistories(
      @Header("Authorization") String token, @Path('id') int id);

  @GET("${APIPath.getTicketDetail}={id}&&status={status}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<TicketLog> getTicketDetail(@Header("Authorization") String token,
      @Path('id') int id, @Path('status') String status);

  @POST(APIPath.request)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Ticket> requestSOS(
      @Header("Authorization") String token, @Body() dynamic body);

  @POST(APIPath.claimRequest)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> claimRequest(
      @Header("Authorization") String token, @Body() dynamic body);

  @GET(APIPath.getPurpose)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Purpose>> getPurpose();

  @GET(APIPath.getProvince)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Province>> getProvinces();

  @POST(APIPath.updateProfile)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<User> updateProfile(
      @Header("Authorization") String token, @Body() dynamic body);

  @POST(APIPath.registerRequest)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<User> registerRequest(@Body() dynamic body);

  @GET(APIPath.sosPending)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Ticket>> getSOSPending(@Header("Authorization") String token);

  @GET("${APIPath.getSOSTicketDetail}{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Ticket> getTicketData(
      @Header("Authorization") String token, @Path('id') int id);

  @POST("${APIPath.sosRequestAction}/{action}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<dynamic> sosRequestAction(@Header("Authorization") String token,
      @Path('action') String action, @Body() dynamic body);

  @GET("${APIPath.getSosProcessing}{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<SOSLogs>> getSOSProcessing(
      @Header("Authorization") String token, @Path('id') int id);

  @POST(APIPath.confirmOTP)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> confirmOTP(
      @Header("Authorization") String token, @Body() dynamic body);

  @POST(APIPath.uploadRegister)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> registerUploadFile(
      @Part(name: 'filetoupload') File file);

  @POST(APIPath.register)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> register(@Body() dynamic body);

  @GET("${APIPath.getCertificateScan}/{code}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ScanCertificate> getCertificateScan(
      @Header("Authorization") String token, @Path('code') String code);

  @GET("${APIPath.getCertificateMember}/{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<CertificateMember>> getCertificateMember(
      @Header("Authorization") String token, @Path('id') int? id);

  @GET("${APIPath.getUserById}/{id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<User> getUserById(
      @Header("Authorization") String token, @Path('id') int id);

  @POST(APIPath.forgotPassword)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<User?> forgotPassword(@Body() dynamic body);

  @POST(APIPath.resetPassword)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<dynamic> resetPassword(@Body() dynamic body);

  @GET("${APIPath.ticketDetail}={id}")
  @Headers(<String, dynamic>{
    "Content-Type": "application/json;charset=UTF-8",
    "Charset": "utf-8"
  })
  Future<Ticket> getTicketInfo(
      @Header("Authorization") String token, @Path('id') int id);

  @GET("${APIPath.getMessage}={id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<SOSMessage>> getMessage(
      @Header("Authorization") String token, @Path('id') int id);

  @POST(APIPath.sendMessage)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<dynamic> sendMessage(
      @Header("Authorization") String token, @Body() dynamic body);

  @POST(APIPath.cancelTicket)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Ticket>cancelTicket(@Header("Authorization") String token, @Body() dynamic body);

  @POST(APIPath.acepted)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Ticket>acceptTicket(@Header("Authorization") String token, @Body() dynamic body);


  @POST(APIPath.completed)
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<Ticket>completeTicket(@Header("Authorization") String token, @Body() dynamic body);

  @GET("${APIPath.sosStaff}={id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<List<Ticket>> getTicketStaff(
      @Header("Authorization") String token, @Path('id') int id);

  @PUT("${APIPath.userCancel}={id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<ResponseData> userCancel(
      @Header("Authorization") String token, @Path('id') int id);

  //Location log
  @GET("${APIPath.location}={id}")
  @Headers(<String, dynamic>{"Content-Type": "application/json"})
  Future<LocationLog>getLiveLocation(@Header("Authorization") String token, @Path('id') int id);
}
