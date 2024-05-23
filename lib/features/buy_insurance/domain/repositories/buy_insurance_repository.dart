import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/insurance.dart';
import '../../../../core/models/insurance_package.dart';

abstract class BuyInsuranceRepository {
  Future<Either<Failure,List<Insurance>>>getInsuranceType();
  Future<Either<Failure,List<InsurancePackage>>>getInsurancePackage({required int id});
  
}