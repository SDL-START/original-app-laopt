import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:insuranceapp/core/models/name.dart';

part 'languages.freezed.dart';
part 'languages.g.dart';

@freezed
@HiveType(typeId: 1)
class Languages with _$Languages{
  const factory Languages({
    @HiveField(0)
    int? id,
    @HiveField(1)
    String? code,
    @HiveField(2)
    Name? name,
  }) = _Languages;
  factory Languages.fromJson(Map<String,dynamic>json)=>_$LanguagesFromJson(json);
}