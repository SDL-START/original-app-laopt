import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:insuranceapp/core/models/pt_image.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/core/usecases/usecase.dart';
import 'package:insuranceapp/features/home/domain/repositories/home_repository.dart';

@lazySingleton
class GetSlideImageUsecase implements UseCase<List<PTImage>, NoParams> {
  final HomeRepository homeRepository;

  GetSlideImageUsecase(this.homeRepository);
  @override
  Future<Either<Failure, List<PTImage>>> call(NoParams params) async {
    return await homeRepository.getSlideImage();
  }
}
