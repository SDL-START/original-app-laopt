// ignore_for_file: constant_identifier_names

import 'package:insuranceapp/core/models/province.dart';
import 'package:insuranceapp/core/models/purpose.dart';

enum RegisterStatus{
  INITAL,
  LOADING,
  LAODED,
  FAILURE,
  REQUESTED,
  CONFIRMED,
  PURPOSED,
  UPLOAD_FAILE,
  UPLOADED,
  VALIDAT_FAILE,
  VALIDATED,
  REGISTER_SUCCESS
}

class RegisterState {
	final RegisterStatus status;
	final String? error;
  final List<Purpose>listPurpose;
  final List<Province>listProvince;
	  
	const RegisterState({
		this.status = RegisterStatus.INITAL,
		this.error,
    this.listPurpose=const [],
    this.listProvince =const [],
	});
	  
	RegisterState copyWith({
		RegisterStatus? status,
		String? error,
    List<Purpose>?listPurpose,
    List<Province>?listProvince,
	}) {
		return RegisterState(
			status: status ?? this.status,
			error: error ?? this.error,
      listPurpose: listPurpose??this.listPurpose,
      listProvince: listProvince?? this.listProvince
		);
	}
}
