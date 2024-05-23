import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetGenerateQRUsecase implements UseCase<dynamic, GetGenerateQRParams> {
  final HomeRepository homeRepository;

  GetGenerateQRUsecase(this.homeRepository);

  @override
  Future<Either<Failure, dynamic>> call(GetGenerateQRParams params) async {
    return await homeRepository.getGenerateQR(
        id: params.id, amount: params.amount);
  }
}

class GetGenerateQRParams extends Equatable {
  final String id;
  final String amount;

  const GetGenerateQRParams({required this.id, required this.amount});

  @override
  List<Object?> get props => [id, amount];
}
