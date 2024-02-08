import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/extensions/either_extension.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/models/ticket.dart';
import '../../../../../core/models/user.dart';
import '../../../../../core/usecases/no_params.dart';
import '../../../../../core/utils/app_navigator.dart';
import '../../../../app/domain/usecases/get_user_local_usecase.dart';
import '../../../domain/usecases/get_ticket_info_usecase.dart';
import '../../../domain/usecases/get_ticket_stream_usecase.dart';
import '../../../domain/usecases/user_cancel_usecase.dart';

part 'support_cubit.freezed.dart';
part 'support_state.dart';

@injectable
class SupportCubit extends Cubit<SupportState> {
  final GetTicketStreamUsecase _getTicketStreamUsecase;
  final GetTicketInfoUsecase _getTicketInfoUsecase;
  final GetUserLocalUsecase _getUserLocalUsecase;
  final UserCancelUsecase _cancelUsecase;
  SupportCubit(
    this._getTicketStreamUsecase,
    this._getTicketInfoUsecase,
    this._getUserLocalUsecase,
    this._cancelUsecase,
  ) : super(const SupportState());

  StreamController<List<Ticket>>? _getTicketController;
  StreamSubscription<List<Ticket>>? _getTicketSubscription;

  Future<void> getCurrentuser() async {
    final currentuser = _getUserLocalUsecase(NoParams());
    emit(state.copyWith(currentUser: currentuser));
  }

  void getTicket() {
    emit(state.copyWith(status: DataStatus.loading));
    if (_getTicketController != null) {
      _getTicketController?.close();
    }
    _getTicketController = StreamController<List<Ticket>>();
    try {
      final streamTicket = _getTicketStreamUsecase(_getTicketController!);
      if (_getTicketSubscription != null) {
        _getTicketSubscription?.cancel();
      }
      _getTicketSubscription = streamTicket.listen((tickets) {
        // tickets.sort((a, b) => b.updatedAt!.toLocal().compareToNull(a.updatedAt!.toLocal()));
        tickets = tickets.reversed.toList();
        emit(state.copyWith(status: DataStatus.success, listTicket: tickets));
      });
    } catch (e) {
      close();
      emit(state.copyWith(status: DataStatus.failure, error: e.toString()));
    }
  }

  Future<void> getTicketDetail(Ticket ticket) async {
    emit(state.copyWith(status: DataStatus.loading));
    final ticketInfo = await _getTicketInfoUsecase(ticket.ticketId);
    if (ticketInfo.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: ticketInfo.getLeft()?.msg));
    } else {
      final ticket = ticketInfo.getRight();
      emit(state.copyWith(status: DataStatus.success, ticket: ticket));
    }
  }

  Future<void> userCancel({required int ticketId}) async {
    emit(state.copyWith(status: DataStatus.loading));
    final result = await _cancelUsecase(ticketId);
    if (result.isLeft()) {
      emit(state.copyWith(
          status: DataStatus.failure, error: result.getLeft()?.msg));
    } else {
      print("Cancelled");
      AppNavigator.goBack();
    }
  }

  @override
  Future<void> close() async {
    await _getTicketController?.close();
    await _getTicketSubscription?.cancel();
    return super.close();
  }
}
