import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:new_version/new_version.dart';

import '../../../login/domain/usecases/get_intial_platform_location_usecase.dart';
import '../../domain/usecases/get_user_local_usecase.dart';
import '../../domain/usecases/on_message_stream_usecase.dart';
import '../../domain/usecases/setup_notification_usecase.dart';

part 'app_cubit.freezed.dart';
part 'app_state.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  final GetUserLocalUsecase _getUserLocalUsecase;
  final GetInitialPlatformLocationUsecase _getInitialPlatformLocationUsecase;
  final SetupNotificationUsecase _setupNotificationUsecase;
  final OnMessageStreamUsecase _messageStreamUsecase;
  AppCubit(
    this._getUserLocalUsecase,
    this._getInitialPlatformLocationUsecase,
    this._setupNotificationUsecase,
    this._messageStreamUsecase,
  ) : super(const AppState());
  Future<void> initialApp() async {
    await Future.wait([
      getInitialLocation(),
      setupNotification(),
      checkNewVersion(),
      getAuthorized()
    ]);
  }

  Future<void> getAuthorized() async {
    emit(state.copyWith(status: DataStatus.loading));
    final user = _getUserLocalUsecase(NoParams());
    emit(
      state.copyWith(
        status: DataStatus.success,
        isAuth: user.token != null,
      ),
    );
  }

  Future<void> getInitialLocation() async {
    final res = await _getInitialPlatformLocationUsecase(NoParams());
    if (res.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: res.getLeft()?.msg));
    }
  }

  Future<void> setupNotification() async {
    final noti = await _setupNotificationUsecase(NoParams());
    _messageStreamUsecase(NoParams());
    if (noti.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: noti.getLeft()?.msg));
    }
  }


  Future<void> checkNewVersion() async {
    final newVersion = NewVersion(
        androidId: "com.thavisub.laopt",
        iOSId: "com.thavisubinsurancebroker.laopt");
    final status = await newVersion.getVersionStatus();
    emit(state.copyWith(versionStatus: status));
  }
  
}
