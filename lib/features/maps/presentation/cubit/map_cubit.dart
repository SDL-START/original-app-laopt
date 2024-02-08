import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/features/hospitals/domain/usecases/get_hospital_service.dart';
import 'package:insuranceapp/features/maps/presentation/cubit/map_state.dart';
import 'package:location/location.dart';

import '../../../../core/error/location_distance.dart';
import '../../../login/domain/usecases/get_intial_platform_location_usecase.dart';
import '../../domain/usecases/get_calculate_distance_usecase.dart';
import '../../domain/usecases/get_current_location_usecase.dart';

@injectable
class MapCubit extends Cubit<MapState> {
  final GetHospitalService _getHospitalService;
  final GetCalculateDistanceUsecase _calculateDistanceUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  final GetInitialPlatformLocationUsecase _getInitialPlatformLocationUsecase;
  MapCubit(
    this._getHospitalService,
    this._getCurrentLocationUsecase,
    this._calculateDistanceUsecase,
    this._getInitialPlatformLocationUsecase,
  ) : super(const MapState());

  List<Hospital> listHospital = [];
  LocationData? currentLocationData;
  List<LocationDistance> listDistamce = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  final Completer<GoogleMapController> controller = Completer();

  Future<void> getInitialLocation() async {
    emit(state.copyWith(status: MapStatus.LOADING));
    final res = await _getInitialPlatformLocationUsecase(NoParams());
    res.fold(
        (er) => null, (r) => emit(state.copyWith(status: MapStatus.LOADED)));
  }

  Future<void> getHospital() async {
    listDistamce.clear();
    emit(state.copyWith(status: MapStatus.LOADING));
    final result = await _getHospitalService(NoParams());
    result.fold((e) => emit(state.copyWith(status: MapStatus.FAILURE)),
        (res) async {
      listHospital = res;
      await getCalculateDistance(list: res);
      if (res.isNotEmpty) {
        for (var location in res) {
          //Add marker
          markers.putIfAbsent(
            MarkerId("${location.id ?? 0}"),
            () => Marker(
              markerId: MarkerId("${location.id ?? 0}"),
              position: LatLng(double.parse(location.lat ?? '0'),
                  double.parse(location.lng ?? '0')),
              infoWindow: InfoWindow(
                title: location.name,
                snippet: location.address,
              ),
              icon: (location.type == "1")
                  ? BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueRed,
                    )
                  : BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueYellow,
                    ),
            ),
          );
        }
      }
      listDistamce.sort((a, b) =>
          (a.distance == null) ? 0 : a.distance!.compareTo(b.distance ?? 0));
      if (super.isClosed) return;
      emit(state.copyWith(status: MapStatus.LOADED));
    });
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(status: MapStatus.LOADING));
    final result = await _getCurrentLocationUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: MapStatus.FAILURE, error: er.msg)),
        (res) {
      currentLocationData = res;
      markers.putIfAbsent(
        const MarkerId('current'),
        () => Marker(
          position: LatLng(res?.latitude ?? 0, res?.longitude ?? 0),
          infoWindow: const InfoWindow(
            title: 'You',
          ),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          markerId: const MarkerId('current'),
        ),
      );
      emit(state.copyWith(status: MapStatus.LOADED));
    });
  }

  Future<void> myLocation({required double lat, required double lng}) async {
    final GoogleMapController myController = await controller.future;
    myController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          zoom: 15,
        ),
      ),
    );
  }

  Future<void> getCalculateDistance({required List<Hospital> list}) async {
    for (var hospital in list) {
      final result = await _calculateDistanceUsecase(GetCalculateDistanceParams(
          distantLat: double.parse(hospital.lat ?? '0'),
          distantLong: double.parse(hospital.lng ?? '0')));
      result.fold((er) => null, (dis) {
        listDistamce.add(LocationDistance(
          id: hospital.id,
          name: hospital.name,
          type: hospital.type,
          distance: Utils.calculateKm(dis),
        ));
      });
    }
  }
}
