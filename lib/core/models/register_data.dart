import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/province.dart';
part 'register_data.freezed.dart';
part 'register_data.g.dart';
@freezed
class RegisterData with _$RegisterData {
  const factory RegisterData({
    String? email,
    String? phone,
    String? purpose,
    String? dateofbirth,
    String? firstname,
    String? lastname,
    String? passport,
    String? countrycode,
    Province? province,
    int? provinceid,
    String? workplace,
    String? photopassport,
    String? photovaccine,
    String? photortpcr,
    String? otp,
    String? type,
    String? gender,
    String? address,
    String? city,
    String? idtype,
  }) = _RegisterData;

  factory RegisterData.fromJson(Map<String,dynamic>json)=>_$RegisterDataFromJson(json);
}
