import 'package:freezed_annotation/freezed_annotation.dart';
part 'insurance.freezed.dart';
part 'insurance.g.dart';
@freezed
class Insurance with _$Insurance{
  const factory Insurance({
    int? id,
    String? name,
    String? photo,
    bool? deleted,
    String? status,
    String? orderno,
    String? description,
  })=_Insurance;

  factory Insurance.fromJson(Map<String,dynamic>json)=>_$InsuranceFromJson(json);
}