import 'package:flutter_flavor/flutter_flavor.dart';
class APIPath {
  //Get flavor variable
  static String baseUrl = FlavorConfig.instance.variables['baseUrl'];

  static const String loginUrl = "/login";
  static const String getLang = "/language/gets";
  static const String getTranslate = "/translation/gets";
  static const String getTranslateJson = "/translation/json";
  static const String postChangePassword = "/user/changepassword";
  static const String getSlideImage = "/imageslide/gets";
  static const String getMenu = "/menu/gets";
  static const String getHospital = "/hospitals";
  static const String getInsuranceType = "/insurancetype/gets";
  static const String getInsurancePackage = "/insurancepackage/getbytype";
  static const String upload = "/upload";
  static String publicUrl = '$baseUrl/public/';
  static const String createCertificate = '/certificate/create';
  static const String generateQr = '/qronepay';
  static const String getInsurance = '/myinsurance/gets';
  static const String getClaim = '/claim/gets';
  static const String getClaimLog = '/claim/getlogs/';
  static const String getClaimType = '/claimtypes';
  static const String getPaidInsurance = '/myinsurance/gets?status=PAID';
  static const String getHospitalServcie = '/hospitalsandservices';
  // static const String getTicketByUser = '/sos/request/user?userid';
  static const String getTicketDetail = '/sos/detail?ticket_id';
  // static const String requestSOS = '/sos/request';
  static const String claimRequest = '/claim/request';
  static const String getPurpose = '/purposes';
  static const String getProvince = '/provinces';
  static const String updateProfile = '/profile/confirm';
  static const String registerRequest = '/register/request';
  static const String getSOSTicketDetail = '/sos/request/id?ticket_id=';
  static const String sosRequestAction = '/staff/sos';
  static const String getSosProcessing =
      '/staff/sos/log?status=PROCESSING&userid=';
  static const String confirmOTP = '/register/confirmotp';
  static const String uploadRegister = '/registerupload';
  static const String register = '/register/confirm';
  static const String getCertificateScan = '/certificate/get';
  static const String getCertificateMember = '/myinsurance/getmembers';
  static const String getUserById = '/user/get';
  static const String forgotPassword = '/forgotpassword/request';
  static const String resetPassword = '/forgotpassword/confirm';

  //SOS Service
  static const String request ="/sosservice/request";
  static const String sosPending = '/sosservice/pending';
  static const String sosStaff = '/sosservice/staff?userId';
  static const String ticketHistories="/sosservice/histories?userId";
  static const String ticketDetail="/sosservice/ticketInfo?ticketId";
  static const String cancelTicket="/sosservice/canceled";
  static const String acepted="/sosservice/accepted";
  static const String completed="/sosservice/completed";
  static const String getMessage="/sosmessage/?ticketId";
  static const String sendMessage="/sosmessage/send";
  static const String userCancel="/sosservice/cancel?ticketId";
  static const String location="/location/live?messageId";
  static const String saveLocation="/location/save";
  
}
