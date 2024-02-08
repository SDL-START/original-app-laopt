import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
part 'name.freezed.dart';
part 'name.g.dart';
@freezed
@HiveType(typeId: 0)
class Name with _$Name {
  const factory Name({
    @HiveField(0)
    String? la,
    @HiveField(1)
    String? us,
    @HiveField(2)
    String? cn,
    @HiveField(3)
    String? vn,
  }) = _Name;
  factory Name.fromJson(Map<String,dynamic>json)=>_$NameFromJson(json);
}
