import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/error/failures.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';
import 'package:insuranceapp/core/models/ticket_action.dart';
import 'package:location/location.dart';

import '../../../../core/models/ticket.dart';
import '../../../../core/models/user.dart';
import '../../../../core/usecases/no_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../../core/utils/utils.dart';
import '../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../chats/domain/usecases/get_ticket_user_usecase.dart';
import '../../../maps/domain/usecases/get_current_location_usecase.dart';
import '../../domain/usecases/accept_ticket_usecase.dart';
import '../../domain/usecases/cancel_ticket_usecase.dart';
import '../../domain/usecases/complete_ticket_usecase.dart';
import '../../domain/usecases/get_sos_pending.dart';
import '../../domain/usecases/get_ticket_detail_usecase.dart';

part 'sos_cubit.freezed.dart';
part 'sos_state.dart';

@injectable
class SosCubit extends Cubit<SosState> {
  final GetSOSPendingUsecase _getSOSPendingUsecase;
  final GetTicketDetail _getTicketDetail;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final GetCurrentLocationUsecase _getCurrentLocationUsecase;
  final GetTicketHistories _getTicketHisories;
  final CancelTicketUsecase _cancelTicketUsecase;
  final AcceptTicketUsecase _acceptTicketUsecase;
  final CompleteTicketUsecase _completeTicketUsecase;

  late TextEditingController descriptionController;
  late Completer<GoogleMapController> mapController;

  SosCubit(
    this._getSOSPendingUsecase,
    this._getTicketDetail,
    this._getUserLocalUsecase,
    this._getCurrentLocationUsecase,
    this._getTicketHisories,
    this._cancelTicketUsecase,
    this._acceptTicketUsecase,
    this._completeTicketUsecase,
  ) : super(const SosState()) {
    descriptionController = TextEditingController();
    mapController = Completer<GoogleMapController>();
  }
  Future<void> getSOSPending() async {
    emit(state.copyWith(status: DataStatus.loading));
    final sos = await _getSOSPendingUsecase(NoParams());
    if (sos.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: sos.getLeft()?.msg));
    } else {
      final List<Ticket> listTicket =
          sos.getRight()?.where((ticket) => ticket.user != null).toList() ?? [];
      emit(state.copyWith(status: DataStatus.success, listTicket: listTicket));
    }
  }

  Future<void> getCurrentUser() async {
    emit(state.copyWith(status: DataStatus.loading));
    final currentuser = _getUserLocalUsecase(NoParams());
    emit(state.copyWith(status: DataStatus.success, currentuser: currentuser));
  }

  Future<void> getCurrentLocation() async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getCurrentLocationUsecase(NoParams());
    result.fold(
        (error) =>
            emit(state.copyWith(status: DataStatus.failure, error: error.msg)),
        (locationData) {
      emit(
        state.copyWith(
          status: DataStatus.success,
          locationData: locationData,
        ),
      );
    });
  }

  Future<void> getTicketDetail({required int id}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _getTicketDetail(id);
    result.fold(
        (error) =>
            emit(state.copyWith(status: DataStatus.failure, error: error.msg)),
        (ticket) {
      emit(state.copyWith(status: DataStatus.success, ticket: ticket));
    });
  }

  Future<void> getTicketHistory() async {
    emit(state.copyWith(status: DataStatus.loading));
    final histories = await _getTicketHisories(NoParams());
    if (histories.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: histories.getLeft()?.msg));
    } else {
      final tickets = histories.getRight();
      tickets?.sort((a, b) => -a.createdAt!
          .toIso8601String()
          .compareTo(b.createdAt!.toIso8601String()));
      emit(state.copyWith(
          status: DataStatus.success, listTicket: tickets ?? []));
    }
  }

  Future<void> ticketAction(
      {TicketActions ticketActions = TicketActions.CANCELED}) async {
    emit(state.copyWith(status: DataStatus.loading));
    TicketAction action = TicketAction(
      ticketId: state.ticket?.ticketId,
      staffId: state.currentuser?.id,
      lat: state.locationData?.latitude,
      lng: state.locationData?.longitude,
      acc: state.locationData?.accuracy,
      description: descriptionController.text.isEmpty
          ? ticketActions.name
          : descriptionController.text,
      status: ticketActions.name,
    );
    Either<Failure, Ticket>? result;
    if (ticketActions == TicketActions.CANCELED) {
      result = await _cancelTicketUsecase(action);
    } else if (ticketActions == TicketActions.INPROGRESS) {
      result = await _acceptTicketUsecase(action);
    } else if (ticketActions == TicketActions.COMPLETED) {
      result = await _completeTicketUsecase(action);
    }
    if (result?.isLeft() == true) {
      emit(
        state.copyWith(
          status: DataStatus.failure,
          error: result?.getLeft()?.msg,
        ),
      );
    } else {
      AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
    }
  }

  Future<void> moveLocation({required double lat, required double lng}) async {
    final controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(lat, lng),
        zoom: 18,
      ),
    ));
  }

  String getLocationDistance({required double lat, required double lng}) {
    final distance = Geolocator.distanceBetween(
        state.locationData?.latitude ?? 0,
        state.locationData?.longitude ?? 0,
        lat,
        lng);
    final dis = Utils.calculateKm(distance);

    return "$dis Km";
  }
}
