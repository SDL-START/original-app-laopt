import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:insuranceapp/core/models/translate.dart';

part 'translations.freezed.dart';
part 'translations.g.dart';
@freezed
@HiveType(typeId: 3)
class Translations with _$Translations {
  const factory Translations({
    @HiveField(0) int? id,
    @HiveField(1) String? word,
    @HiveField(2) String? route,
    @HiveField(3) Translate? translate,
  }) = _Translations;

  factory Translations.fromJson(Map<String,dynamic>json)=>_$TranslationsFromJson(json);
}
