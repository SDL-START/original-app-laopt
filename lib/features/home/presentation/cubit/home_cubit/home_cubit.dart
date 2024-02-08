import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:location/location.dart';

import '../../../../../core/models/menu.dart';
import '../../../../../core/models/pt_image.dart';
import '../../../../../core/models/request_sos.dart';
import '../../../../../core/models/user.dart';
import '../../../../../core/usecases/no_params.dart';
import '../../../../../core/utils/app_navigator.dart';
import '../../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../../maps/domain/usecases/get_current_location_usecase.dart';
import '../../../domain/usecases/get_menu_usecase.dart';
import '../../../domain/usecases/get_slide_image_usecase.dart';
import '../../../domain/usecases/request_sos_usecase.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final RequestSOSUsecase _requestSOSUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final GetMenuUsecase _getMenuUsecase;
  final GetSlideImageUsecase _getSlideImageUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  HomeCubit(
    this._requestSOSUsecase,
    this._getUserLocalUsecase,
    this._getMenuUsecase,
    this._getSlideImageUsecase,
    this._getCurrentLocationUsecase,
  ) : super(const HomeState());

  Future<void> initial() async {
    await Future.wait([
      getUser(),
      getSlideImage(),
      getMenu(),
      getCurrentLocation(),
    ]);
  }

  Future<void> getUser() async {
    emit(state.copyWith(status: DataStatus.loading));
    final user = _getUserLocalUsecase(NoParams());
    emit(state.copyWith(currentUser: user, status: DataStatus.success));
  }

  Future<void> getMenu() async {
    emit(state.copyWith(status: DataStatus.loading));
    final menu = await _getMenuUsecase(NoParams());
    if (menu.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: menu.getLeft()?.msg));
    } else {
      if(super.isClosed)return;
      emit(state.copyWith(
        status: DataStatus.success,
        listMenu: menu.getRight() ?? [],
      ));
    }
  }

  Future<void> getSlideImage() async {
    emit(state.copyWith(status: DataStatus.loading));
    final listImage = await _getSlideImageUsecase(NoParams());
    if (listImage.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: listImage.getLeft()?.msg));
    } else {
      if (super.isClosed) return;
      emit(state.copyWith(
        listSlideImage: listImage.getRight() ?? [],
        status: DataStatus.success,
      ));
    }
  }

  Future<void> getCurrentLocation() async {
    final location = await _getCurrentLocationUsecase(NoParams());
    if (location.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: location.getLeft()?.msg));
    } else {
      if (super.isClosed) return;
      emit(state.copyWith(
        currentLocation: location.getRight(),
      ));
    }
  }

  Future<void> requestSOS() async {
    emit(state.copyWith(status: DataStatus.requesting));
    RequestSOS data = RequestSOS(
      requesterId: state.currentUser?.id,
      lat: state.currentLocation?.latitude,
      lng: state.currentLocation?.longitude,
      acc: state.currentLocation?.accuracy,
      description: 'SOS',
    );
    final request = await _requestSOSUsecase(data);
    if (request.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: request.getLeft()?.msg));
    } else {
      final ticket = request.getRight();
      emit(state.copyWith(
          status: DataStatus.success, message: "SOS has been sent"));
      AppNavigator.navigateTo(AppRoute.sosRequestDetailRoute, params: ticket);
    }
  }
}
