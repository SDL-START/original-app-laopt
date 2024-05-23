import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';

import '../../../../core/models/hospital.dart';
import '../../../../core/usecases/no_params.dart';
import '../../domain/usecases/get_hospital_service.dart';

part 'hospital_state.dart';
part 'hospital_cubit.freezed.dart';

@injectable
class HospitalCubit extends Cubit<HospitalState> {
  final GetHospitalService _getHospitalService;
  HospitalCubit(
    this._getHospitalService,
  ) : super(const HospitalState());

  Future<void> getHospitalService() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getHospitalService(NoParams());
    result.fold((e) => emit(state.copyWith(status: DataStatus.failure)),
        (hospital) {
      emit(state.copyWith(status: DataStatus.success, hospitals: hospital));
    });
  }
}
