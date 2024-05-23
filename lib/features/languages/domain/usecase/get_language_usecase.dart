import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';

import '../../../../core/usecases/usecase_sync.dart';
import '../repositories/lang_repository.dart';

@lazySingleton
class GetLanguageUsecase implements SynchronousUseCase<String?,NoParams>{
  final LangRepository _langRepository;

  GetLanguageUsecase(this._langRepository);
  
  @override
  String? call(NoParams params) {
    return _langRepository.getLanguageCode();
  }
}