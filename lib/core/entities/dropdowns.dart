import 'package:equatable/equatable.dart';

class Dropdowns  extends Equatable{
  final String? name;
  final dynamic value;
  const Dropdowns({this.name,this.value});
  @override
  String toString() => '$name';
  
  @override
  List<Object?> get props => [name,value];
}