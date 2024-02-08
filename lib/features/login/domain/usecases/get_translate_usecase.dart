// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:insuranceapp/core/error/failures.dart';
// import 'package:insuranceapp/core/usecases/no_params.dart';
// import 'package:insuranceapp/core/usecases/usecase.dart';

// import '../../../../core/models/translations.dart';
// import '../repositories/auth_repository.dart';

// @lazySingleton
// class GetTranslateUsecase implements UseCase<List<Translations>, NoParams> {
//   final AuthRepository authRepository;

//   GetTranslateUsecase(this.authRepository);

//   @override
//   Future<Either<Failure, List<Translations>>> call(NoParams params) async {
//     return await authRepository.getTranslation();
//   }
// }
