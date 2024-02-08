import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/hospital.dart';

abstract class HospitalRepository {
  Future<Either<Failure, List<Hospital>>> getHospitalService();
}
