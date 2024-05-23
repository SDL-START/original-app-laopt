import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';

import '../../../../core/models/response_qr.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class PayBCELUsecase implements UseCase<Responseqr, PayBCELParams> {
  final HomeRepository homeRepository;

  PayBCELUsecase(this.homeRepository);
  @override
  Future<Either<Failure, Responseqr>> call(PayBCELParams params) async {
    return await homeRepository.payBCEL(id: params.id, amount: params.amount);
  }
}

class PayBCELParams extends Equatable {
  final String id;
  final String? amount;

  const PayBCELParams({required this.id, this.amount});

  @override
  List<Object?> get props => [id, amount];
}
