
import 'package:freezed_annotation/freezed_annotation.dart';
part 'response_dropdown.freezed.dart';
part 'response_dropdown.g.dart';
@freezed
class ResponseDropdown with _$ResponseDropdown{
  const factory ResponseDropdown({
    final String? name,
    final String? value,
  })=_ResponseDropdown;

  factory ResponseDropdown.fromJson(Map<String,dynamic>json)=>_$ResponseDropdownFromJson(json);
}