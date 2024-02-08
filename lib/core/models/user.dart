import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
@HiveType(typeId: 4)
class User with _$User {
  const factory User({
    @HiveField(0) int? id,
    @HiveField(1) String? phone,
    @HiveField(2) String? password,
    @HiveField(3) String? firstname,
    @HiveField(4) String? lastname,
    @HiveField(5) DateTime? registerdate,
    @HiveField(6) String? photo,
    @HiveField(7) String? gender,
    @HiveField(8) String? passport,
    @HiveField(9) String? status,
    @HiveField(10) DateTime? dob,
    @HiveField(12) String? email,
    @HiveField(13) int? province_id,
    @HiveField(14) String? token,
    @HiveField(15) String? idtype,
    @HiveField(16) String? role,
    @HiveField(17) String? purposeofvisit,
    @HiveField(18) String? resident,
    @HiveField(19) String? workplace,
    @HiveField(20) String? street,
    @HiveField(21) String? city,
    @HiveField(22) String? address,
    @HiveField(23) String? countrycode,
    @HiveField(24) String? position,
    @HiveField(25) String? hospitalId,
    @HiveField(26) String? servicelocationId,
    @HiveField(27) String? firebasetoken,
    @HiveField(28) String? relation,
    @HiveField(29) String? photopassport,
    @HiveField(30) String? photovaccine,
    @HiveField(31) String? photortpcr,
    @HiveField(32) String? postalcode,
    @HiveField(33) String? photoprofile,
    @HiveField(34) int? provinceId,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
