import 'package:freezed_annotation/freezed_annotation.dart';
part 'insurance_package.freezed.dart';
part 'insurance_package.g.dart';

@freezed
class InsurancePackage with _$InsurancePackage {
  const factory InsurancePackage({
    int? id,
    String? name,
    String? price,
    String? currency,
    DateTime? lastupdate,
    int? employee_id,
    String? terms,
    String? status,
    String? orderno,
    int? insurancetype_id,
    int? period,
    String? description,
  }) = _InsurancePackage;

  factory InsurancePackage.fromJson(Map<String, dynamic> json) =>_$InsurancePackageFromJson(json);
}
