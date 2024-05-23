import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:location/location.dart';

import '../repositories/map_repository.dart';

@lazySingleton
class GetCurrentLocationUsecase implements UseCase<LocationData?, NoParams> {
  final MapRepository _mapRepository;

  GetCurrentLocationUsecase(this._mapRepository);

  @override
  Future<Either<Failure, LocationData?>> call(NoParams params) async {
    return await _mapRepository.getCurrentLocation();
  }
}
