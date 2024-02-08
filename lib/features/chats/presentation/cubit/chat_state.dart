// ignore_for_file: constant_identifier_names

import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/models/ticket_log.dart';

import '../../../../core/models/user.dart';

enum ChatStatus {
  INITIAL,
  LOADING,
  LOADED,
  FAILURE,
}

class ChatState {
  final ChatStatus status;
  final String? error;
  final List<Ticket> listTicket;
  final TicketLog? ticketLog;
  final User? currentUser;
  final User? user;

  const ChatState({
    this.status = ChatStatus.INITIAL,
    this.error,
    this.listTicket = const [],
    this.ticketLog,
    this.currentUser,
    this.user,
  });

  ChatState copyWith({
    ChatStatus? status,
    String? error,
    List<Ticket>? listTicket,
    TicketLog? ticketLog,
    User? currentUser,
    User? user,
  }) {
    return ChatState(
      status: status ?? this.status,
      error: error ?? this.error,
      listTicket: listTicket ?? this.listTicket,
      ticketLog: ticketLog ?? this.ticketLog,
      currentUser: currentUser ?? this.currentUser,
      user: user ?? this.user,
    );
  }
}
