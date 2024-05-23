import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/models/certificate_response.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class CreateCertificateUsecase
    implements UseCase<CertificateResponse, CreateCertificateParams> {
  final HomeRepository homeRepository;

  CreateCertificateUsecase(this.homeRepository);

  @override
  Future<Either<Failure, CertificateResponse>> call(
      CreateCertificateParams params) async {
    return await homeRepository.createCertificate(body: params.certificate);
  }
}

class CreateCertificateParams extends Equatable {
  final Certificate certificate;

  const CreateCertificateParams(this.certificate);

  @override
  List<Object?> get props => [certificate];
}
