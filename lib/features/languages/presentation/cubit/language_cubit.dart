import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/features/languages/domain/usecase/get_language_usecase.dart';

import '../../domain/usecase/set_language_usecase.dart';

part 'language_cubit.freezed.dart';
part 'language_state.dart';

@injectable
class LanguageCubit extends Cubit<LanguageState> {
  final GetLanguageUsecase _getLanguageUsecase;
  final SetLanguageUsecase _setLanguageUsecase;
  LanguageCubit(
    this._getLanguageUsecase,
    this._setLanguageUsecase,
  ) : super(const LanguageState());

  Future<void> getLanguage() async {
    emit(state.copyWith(status: DataStatus.loading));

    Future.delayed(const Duration(milliseconds: 200), () async {
      final langCode = _getLanguageUsecase(NoParams());
      emit(state.copyWith(
          status: DataStatus.success, langCode: langCode ?? "en"));
    });
  }

  Future<void> setLanguage({required String code}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final lang = await _setLanguageUsecase(code);
    if (lang.isLeft()) {
      emit(state.copyWith(status: DataStatus.failure));
    } else {
      emit(state.copyWith(status: DataStatus.success, langCode: code));
    }
  }
}
