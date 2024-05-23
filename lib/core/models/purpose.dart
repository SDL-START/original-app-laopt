import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/name.dart';
part 'purpose.freezed.dart';
part 'purpose.g.dart';
@freezed
class Purpose with _$Purpose{
  const factory Purpose({
    String? code,
    Name? name,
  })=_Purpose;
  factory Purpose.fromJson(Map<String,dynamic>json)=>_$PurposeFromJson(json);
}