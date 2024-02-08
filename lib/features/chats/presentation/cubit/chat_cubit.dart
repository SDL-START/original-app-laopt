import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:insuranceapp/core/models/sos_logs.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/core/usecases/no_params.dart';
import 'package:insuranceapp/features/chats/domain/usecases/get_ticket_user_usecase.dart';
import 'package:insuranceapp/features/chats/presentation/cubit/chat_state.dart';
import 'package:insuranceapp/features/home/domain/usecases/get_sos_processing_usecase.dart';
import 'package:insuranceapp/features/login/domain/usecases/get_login_usecase.dart';

import '../../../../core/models/messages.dart';
import '../../../../core/models/ticket.dart';
import '../../domain/usecases/get_ticket_detail_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final GetTicketDetailUsecase _getTicketDetailUsecase;
  final GetTicketHistories _getTicketUserUsecase;
  final GetSOSProcessingUsecase _getSOSProcessingUsecase;
  final GetLoginUsecase _getLoginUsecase;
  final GetUserByIdUsecase _getUserByIdUsecase;
  ChatCubit(
      this._getTicketUserUsecase,
      this._getTicketDetailUsecase,
      this._getSOSProcessingUsecase,
      this._getLoginUsecase,
      this._getUserByIdUsecase)
      : super(const ChatState());
  User? currentUser;
  List<SOSLogs> listLog = [];
  // StreamController<List<Messages>>? _getMessageController;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  Future<void> getUserById({required int id}) async {
    emit(state.copyWith(status: ChatStatus.LOADING));
    final result = await _getUserByIdUsecase(id);
    result.fold(
        (l) => emit(state.copyWith(status: ChatStatus.FAILURE, error: l.msg)),
        (r) {
          emit(state.copyWith(status: ChatStatus.LOADED, user: r));
        });
  }

  Future<void> getSOSStaff() async {
    emit(state.copyWith(status: ChatStatus.LOADING));
    final result = await _getSOSProcessingUsecase(NoParams());
    result.fold(
        (l) => emit(state.copyWith(status: ChatStatus.FAILURE, error: l.msg)),
        (res) {
      listLog = res;
      emit(state.copyWith(status: ChatStatus.LOADED));
    });
  }

  Future<void> getCurrentUser() async {
    emit(state.copyWith(status: ChatStatus.LOADING));
    final result = await _getLoginUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: ChatStatus.LOADED, error: er.msg)),
        (user) {
      currentUser = user;
      emit(state.copyWith(status: ChatStatus.LOADED, currentUser: currentUser));
    });
  }

  Future<void> getTicket() async {
    if (super.isClosed) return;
    emit(state.copyWith(status: ChatStatus.LOADING));
    final result = await _getTicketUserUsecase(NoParams());
    result.fold(
        (er) => emit(state.copyWith(status: ChatStatus.LOADED, error: er.msg)),
        (tickes) {
      // tickes.sort((a, b) => -a.create_at!
      //     .toIso8601String()
      //     .compareTo(b.create_at!.toIso8601String()));
      emit(state.copyWith(status: ChatStatus.LOADED, listTicket: tickes));
    });
  }

  Future<void> getTicketDetail({Ticket? ticket}) async {
    emit(state.copyWith(status: ChatStatus.LOADING));
    final result =
        await _getTicketDetailUsecase(GetTicketDetailParams(ticket: ticket));
    result.fold((er) {
      emit(state.copyWith(status: ChatStatus.LOADED, error: er.msg));
    }, (ticketLog) {
      emit(state.copyWith(status: ChatStatus.LOADED, ticketLog: ticketLog));
    });
  }

  Future<void> onSendMessage({required int ticketId}) async {
    if (messageController.text.isNotEmpty) {
      Messages messages = Messages(
          ticketId: ticketId,
          senderId: state.currentUser?.id,
          receiverId: state.ticketLog?.userid,
          message: messageController.text,
          timestamp: DateTime.now());
      final fireStore = FirebaseFirestore.instance;
      await fireStore.collection('messages').add(messages.toJson());
      messageController.clear();
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }
}
