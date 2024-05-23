import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/province.dart';
part 'register.freezed.dart';
part 'register.g.dart';
@freezed
class Register with _$Register {
  const factory Register({
    String? email,
    String? phone,
    String? purpose,
    String? dateofbirth,
    String? firstname,
    String? lastname,
    String? passport,
    String? countrycode,
    Province? province,
    int? province_id,
    String? workplace,
    String? photopassport,
    String? photovaccine,
    String? photortpcr,
    String? otp,
    String? code,
    String? type,
    String? gender,
    String? address,
    String? city,
    String? idtype,
    String? password,
  }) = _Register;
  factory Register.fromJson(Map<String,dynamic>json)=>_$RegisterFromJson(json);
}
