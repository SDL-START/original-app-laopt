import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';

part 'tab_cubit.freezed.dart';
part 'tab_state.dart';

@injectable
class TabCubit extends Cubit<TabState> {
  TabCubit() : super(const TabState());
  void onChangedTab(int index) {
    emit(state.copyWith(status: DataStatus.loading));
    emit(state.copyWith(
      status: DataStatus.success,
      currentIndex: index,
    ));
  }
}
