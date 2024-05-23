
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'translate.freezed.dart';
part 'translate.g.dart';
@HiveType(typeId: 2)
@freezed
class Translate with _$Translate{
  const factory Translate({
    @HiveField(0)
    String? cn,
    @HiveField(1)
    String? jp,
    @HiveField(2)
    String? la,
    @HiveField(3)
    String? us,
    @HiveField(4)
    String? vn,
  })=_Translate;

  factory Translate.fromJson(Map<String,dynamic>json)=>_$TranslateFromJson(json);
}