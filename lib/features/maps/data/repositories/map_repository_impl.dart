import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/exceptions.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/features/maps/domain/repositories/map_repository.dart';
import 'package:location/location.dart';

import '../datasources/map_remote_datasource.dart';

@LazySingleton(as: MapRepository)
class MapRepositoryImpl implements MapRepository {
  final MapLocationRemoteDatasource _mapLocationRemoteDatasource;

  MapRepositoryImpl(this._mapLocationRemoteDatasource);

  @override
  Future<Either<Failure, LocationData?>> getCurrentLocation() async {
    try {
      final res = await _mapLocationRemoteDatasource.getCurrentLocation();
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }
  
  @override
  Future<Either<Failure, double>> getCalculateDistance({required double distantLat, required double distantLong}) async{
    try {
      final res = await _mapLocationRemoteDatasource.calculateDistance(distantLat: distantLat, distantLong: distantLong);
      return Right(res);
    } on ServerException catch (er) {
      return Left(ServerFailure(er.msg));
    }
  }

}
