import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:location/location.dart';

abstract class MapRepository{
  Future<Either<Failure,LocationData?>>getCurrentLocation();
  Future<Either<Failure,double>>getCalculateDistance({required double distantLat, required double distantLong});
}