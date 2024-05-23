import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class PayCreditUsecase implements UseCase<String, PayCreditParams> {
  final HomeRepository homeRepository;

  PayCreditUsecase(this.homeRepository);

  @override
  Future<Either<Failure, String>> call(PayCreditParams params) async {
    return await homeRepository.payCredit(certificate: params.certificate);
  }
}

class PayCreditParams extends Equatable {
  final Certificate? certificate;

  const PayCreditParams({this.certificate});

  @override
  List<Object?> get props => [certificate];
}
