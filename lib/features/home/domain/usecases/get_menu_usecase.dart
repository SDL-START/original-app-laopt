import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/models/menu.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetMenuUsecase implements UseCase<List<Menu>, NoParams> {
  final HomeRepository homeRepository;

  GetMenuUsecase(this.homeRepository);

  @override
  Future<Either<Failure, List<Menu>>> call(NoParams params) async {
    return await homeRepository.getMenu();
  }
}
