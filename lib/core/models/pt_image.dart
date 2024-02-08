import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/name.dart';
part 'pt_image.freezed.dart';
part 'pt_image.g.dart';
@freezed
class PTImage with _$PTImage{
  const factory PTImage({
    int? id,
    Name? name,
    String? url,
    String? image,

  })=_PTImage;

  factory PTImage.fromJson(Map<String,dynamic>json)=>_$PTImageFromJson(json);
}