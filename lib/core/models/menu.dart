import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:insuranceapp/core/models/name.dart';
part 'menu.freezed.dart';
part 'menu.g.dart';
@freezed
class Menu with _$Menu{
  const factory Menu({
    int? id,
    Name? name,
    String? icon,
    int? iswebview,
    String? url,
    String? status,
    int? position,
    String? platform,
    bool? isLogin,
    String? params,
    String? role,
  })=_Menu;

  factory Menu.fromJson(Map<String,dynamic>json)=>_$MenuFromJson(json);
}