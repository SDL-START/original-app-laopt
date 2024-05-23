// ignore_for_file: constant_identifier_names


enum DataStatus{
  initial,
  loading,
  success,
  failure,
  logout,
  loaded,
  requesting
}
class DatabaseKey {
  static const String dbName = 'akatinsurance';
  static const String languageKey = "Languages";
  static const String translateKey = "Translation";
  static const String userKey = "users";
}

class SharefPrefKey {
  static const String langCode = "langCode";
  static const String email = "email";
  static const String phone = "phone";
  static const String countryCode = "countryCode";
  static const String countryISOCode = "countryISOCode";
  static const String slideImage = "slideImage";
  static const String menu = "menu";

  static const String user = "user";
  static const String loginData = "LoginData";


}

enum NavigationType {
  HOME,
  CHAT,
  MAP,
  PROFILE,
  SETTING,
}

enum FileType { passport, vaccine, rtpcr,profile }

enum PaymentType { BCELONE_PAY, CREDIT_CARD }

class BCELOne {
  static String onepaysubscribeKey =
      'sub-c-91489692-fa26-11e9-be22-ea7c5aada356';
  static String onepaymcid = 'mch5c2f0404102fb';
  static String onepayuuid = 'BCELBANK';
}

enum ValidateType {
  PHONE,
  EMAIL,
}

class TicketStatus {
  static const inprogress ="INPROGRESS";
  static const completed ="COMPLETED";
  static const canceled ="CANCELED";
  static const pending ="PENDING";
}

enum MessageType {
  TEXT,
  FILE,
  LOCATION,
  LIVE_LOCATION
}

class GoogleCredencial{
  static const String googleMapApiKey = "AIzaSyDtrdwVA5bOLRjQmuDkxy7dy3u_syz8J5Q";
}

enum TicketActions{
  CANCELED,
  INPROGRESS,
  COMPLETED
}


