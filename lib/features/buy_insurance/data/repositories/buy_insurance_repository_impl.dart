import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/insurance.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/insurance_package.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/buy_insurance_repository.dart';
import '../datasources/buy_insurance_remote_datasource.dart';

@LazySingleton(as: BuyInsuranceRepository)
class BuyInsuranceRepositoryImpl implements BuyInsuranceRepository {
  final BuyInsuranceRemoteDatasource _buyInsuranceRemoteDatasource;

  BuyInsuranceRepositoryImpl(this._buyInsuranceRemoteDatasource);
  @override
  Future<Either<Failure, List<Insurance>>> getInsuranceType() async {
    try {
      final res = await _buyInsuranceRemoteDatasource.getInsuranceType();
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }

  @override
  Future<Either<Failure, List<InsurancePackage>>> getInsurancePackage(
      {required int id}) async {
    try {
      final res =
          await _buyInsuranceRemoteDatasource.getInsurancePackage(id: id);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.msg));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.msg));
    }
  }
}
