import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/features/login/data/models/login_data.dart';
import 'package:insuranceapp/features/login/domain/repositories/auth_repository.dart';

import '../../../../core/usecases/usecase_sync.dart';

@lazySingleton
class GetLoginDataUseCase implements SynchronousUseCase<LoginData,NoParams>{
  final AuthRepository _authRepository;

  GetLoginDataUseCase(this._authRepository);
  
  @override
  LoginData call(NoParams params) {
    return _authRepository.getLoginData();
  }


}