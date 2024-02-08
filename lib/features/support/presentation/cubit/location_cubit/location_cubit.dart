import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:location/location.dart';

import '../../../../../core/models/location_log.dart';
import '../../../../maps/domain/usecases/get_current_location_usecase.dart';
import '../../../domain/usecases/get_live_location_usecase.dart';

part 'location_cubit.freezed.dart';
part 'location_state.dart';

@injectable
class LocationCubit extends Cubit<LocationState> {
  final GetLiveLocationUsecase _getLiveLocationUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  BitmapDescriptor? icon;
  LocationCubit(
    this._getLiveLocationUsecase,
    this._getCurrentLocationUsecase,
  ) : super(const LocationState());

  StreamController<LocationLog>? _getLocationLogController;
  StreamSubscription<LocationLog>? _getLocationLogSubcription;
  

  void getLiveLocation({int? messageId}) {
    emit(state.copyWith(status: DataStatus.loading));
    if (_getLocationLogController != null) {
      _getLocationLogController?.close();
    }
    _getLocationLogController = StreamController<LocationLog>();

    try {
      final locationStream = _getLiveLocationUsecase(
          GetLiveLocationParams(_getLocationLogController!, messageId));
      if (_getLocationLogSubcription != null) {
        _getLocationLogSubcription?.cancel();
      }
      _getLocationLogSubcription = locationStream.listen((location) {
        emit(state.copyWith(status: DataStatus.success, locationLog: location));
      });
    } catch (e) {
      close();
      emit(state.copyWith(status: DataStatus.failure, error: e.toString()));
    }
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(status: DataStatus.loading));
    final currentLocation = await _getCurrentLocationUsecase(NoParams());
    if (currentLocation.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: currentLocation.getLeft()?.msg));
    } else {
      emit(state.copyWith(
        status: DataStatus.success,
        currentLocation: currentLocation.getRight(),
      ));
    }
  }

  @override
  Future<void> close() async {
    _getLocationLogController?.close();
    _getLocationLogSubcription?.cancel();
    return super.close();
  }
}
