import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:location/location.dart';

@injectable
class LocationService {
  final Location locationService;
  LocationService(this.locationService);

  Future<LocationData?> getCurrentLocation() async {
    try {
      Position? currentPosition = await Geolocator.getCurrentPosition();
      LocationData locationData = LocationData.fromMap(currentPosition.toJson());
      return locationData;
    } catch (exception) {
      throw ServerException(exception.toString());
    }
  }

  Future<void> initPlatformState() async {
    bool serviceEnabled = await locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    PermissionStatus permissionGranted = await locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await getCurrentLocation();
  }

  Future<double> calculateDistance(
      double distantLat, double distantLong) async {
    LocationData? data = await getCurrentLocation();
    if (data == null) {
      return 0;
    }
    return Geolocator.distanceBetween(
        data.latitude ?? 0, data.longitude ?? 0, distantLat, distantLong);
  }

 Stream<LocationData> locationChanged()async*{
  // if(await locationService.isBackgroundModeEnabled()){

  // }
  await locationService.enableBackgroundMode(enable: true);
  yield* locationService.onLocationChanged;
}}
