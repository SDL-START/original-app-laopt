import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/services/location_service.dart';
import 'package:location/location.dart';

abstract class MapLocationRemoteDatasource {
  Future<LocationData?> getCurrentLocation();
  Future<double> calculateDistance(
      {required double distantLat, required double distantLong});
}

@LazySingleton(as: MapLocationRemoteDatasource)
class MapLocationRemoteDatasourceImpl implements MapLocationRemoteDatasource {
  final LocationService _locationService;

  MapLocationRemoteDatasourceImpl(this._locationService);

  @override
  Future<LocationData?> getCurrentLocation() async {
    try {
      final res = await _locationService.getCurrentLocation();
      return res;
    } on ServerException catch (er) {
      throw ServerException(er.msg);
    }
  }

  @override
  Future<double> calculateDistance(
      {required double distantLat, required double distantLong}) async {
    try {
      final res =
          await _locationService.calculateDistance(distantLat, distantLong);
      return res;
    } catch (er) {
      throw CacheException(er.toString());
    }
  }
}
