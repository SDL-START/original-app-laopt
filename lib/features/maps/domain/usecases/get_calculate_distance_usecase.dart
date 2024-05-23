import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/maps/domain/repositories/map_repository.dart';

@lazySingleton
class GetCalculateDistanceUsecase
    implements UseCase<double, GetCalculateDistanceParams> {
  final MapRepository _mapRepository;

  GetCalculateDistanceUsecase(this._mapRepository);

  @override
  Future<Either<Failure, double>> call(
      GetCalculateDistanceParams params) async {
    return await _mapRepository.getCalculateDistance(
        distantLat: params.distantLat, distantLong: params.distantLong);
  }
}

class GetCalculateDistanceParams extends Equatable {
  final double distantLat;
  final double distantLong;

  const GetCalculateDistanceParams(
      {required this.distantLat, required this.distantLong});

  @override
  List<Object?> get props => [distantLat, distantLong];
}
