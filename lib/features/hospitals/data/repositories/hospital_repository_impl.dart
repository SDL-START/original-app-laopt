import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/error/failures.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/hospital_repository.dart';
import '../datasources/hospital_remote_datasource.dart';

@LazySingleton(as: HospitalRepository)
class HospitalRepositoryImpl implements HospitalRepository {
  final HospitalRemoteDatasource _hospitalRemoteDatasourcel;

  HospitalRepositoryImpl(this._hospitalRemoteDatasourcel);
  @override
  Future<Either<Failure, List<Hospital>>> getHospitalService() async {
    try {
      final res = await _hospitalRemoteDatasourcel.getHospitalService();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }
}
