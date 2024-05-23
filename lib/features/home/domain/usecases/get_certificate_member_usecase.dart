import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/certificate_member.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetCertificateMemberUsecase
    implements UseCase<List<CertificateMember>, int?> {
  final HomeRepository _homeRepository;

  GetCertificateMemberUsecase(this._homeRepository);

  @override
  Future<Either<Failure, List<CertificateMember>>> call(int? params) async {
    return await _homeRepository.getCertificateMember(id: params);
  }
}
