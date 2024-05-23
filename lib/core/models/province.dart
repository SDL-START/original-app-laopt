import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/name.dart';
part 'province.freezed.dart';
part 'province.g.dart';

@freezed
class Province with _$Province {
  const factory Province({
    int? id,
    Name? name,
  }) = _Province;

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);
}
