
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class LangRepository {
  String? getLanguageCode();
  Future<Either<Failure, bool>>setLanguageCode({required String code});
}