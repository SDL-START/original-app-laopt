import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.freezed.dart';
part 'photo.g.dart';
@freezed
class Photo with _$Photo{
  const factory Photo({
    String? photoprofile,
    String? photopassport,
    String? photovaccine,
    String? photortpcr,
  })=_Photo;

  factory Photo.fromJson(Map<String,dynamic>json)=>_$PhotoFromJson(json);
}