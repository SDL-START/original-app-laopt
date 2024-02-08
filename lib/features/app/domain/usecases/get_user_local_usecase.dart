import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/features/app/domain/repositories/app_repository.dart';

import '../../../../core/models/user.dart';
import '../../../../core/usecases/usecase_sync.dart';

@lazySingleton
class GetUserLocalUsecase implements SynchronousUseCase<User,NoParams>{
  final AppRepository _appRepository;

  GetUserLocalUsecase(this._appRepository);
  
  @override
  User call(NoParams params) {
    return _appRepository.getLocalUser();
  }
}
