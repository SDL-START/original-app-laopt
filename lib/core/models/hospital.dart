import 'package:freezed_annotation/freezed_annotation.dart';
part 'hospital.freezed.dart';
part 'hospital.g.dart';
@freezed
class Hospital with _$Hospital{
  const factory Hospital({
    int? id,
    String? name,
    String? address,
    String? tel,
    String? hospitaltype,
    String? lat,
    String? lng,
    List<String>? images,
    String? type,
  })=_Hospital;

  factory Hospital.fromJson(Map<String,dynamic>json)=>_$HospitalFromJson(json);
}