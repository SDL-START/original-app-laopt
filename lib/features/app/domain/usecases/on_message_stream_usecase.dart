import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';

import '../../../../core/usecases/usecase_sync.dart';
import '../repositories/app_repository.dart';

@lazySingleton
class OnMessageStreamUsecase implements SynchronousUseCase<void,NoParams>{
  final AppRepository _appRepository;
  OnMessageStreamUsecase(this._appRepository);
  
  @override
  void call(NoParams params) {
    return _appRepository.onMessageStream();
  }
}