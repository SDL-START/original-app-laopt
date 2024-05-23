import 'package:bubble/bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/avatar_widget.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/models/messages.dart';
import '../../../../../core/models/sos_logs.dart';
import '../../cubit/chat_cubit.dart';
import '../../cubit/chat_state.dart';

class ChatStaffPage extends StatelessWidget {
  final SOSLogs? log;
  const ChatStaffPage({super.key, this.log});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("#${log?.ticket_id}"),
        actions: [
          AvatarWidget(
            url: Utils.getProfileUrl(value: cubit.state.user?.photo ?? ''),
            onTap: (){
              AppNavigator.navigateTo(AppRoute.sosDetail,params: log?.ticket_id??0);
            },
          ),
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              //Chat body
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('messages')
                        .where("ticketId", isEqualTo: log?.ticket_id)
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<Messages> list = snapshot.data?.docs
                              .map((e) => Messages.fromJson(e.data()))
                              .toList() ??
                          [];
                      list.sort(((a, b) => a.timestamp!
                          .toIso8601String()
                          .compareTo(b.timestamp!.toIso8601String())));
                      return SingleChildScrollView(
                        controller: cubit.scrollController,
                        child: InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: list.map((message) {
                                return Bubble(
                                  margin: const BubbleEdges.only(top: 10),
                                  alignment: (message.senderId ==
                                          state.currentUser?.id)
                                      ? Alignment.topRight
                                      : Alignment.topLeft,
                                  nipWidth: 8,
                                  nipHeight: 24,
                                  nip: (message.senderId ==
                                          state.currentUser?.id)
                                      ? BubbleNip.rightTop
                                      : BubbleNip.leftTop,
                                  color:
                                      const Color.fromRGBO(225, 255, 199, 1.0),
                                  padding: const BubbleEdges.only(
                                      left: 20, right: 20),
                                  child: Column(  
                                    crossAxisAlignment: (message.senderId ==
                                            state.currentUser?.id)
                                        ? CrossAxisAlignment.end
                                        : CrossAxisAlignment.start,
                                    children: [
                                      Text(message.message ?? ''),
                                      const SizedBox(height: 8),
                                      Text(
                                          Utils.formatTime(message.timestamp
                                              ?.toIso8601String()),
                                          style: const TextStyle(fontSize: 10)),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              //Chat textfield
              Container(
                color: const Color.fromARGB(31, 141, 141, 141),
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Expanded(
                      child: TextField(
                        controller: cubit.messageController,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          isDense: true,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 108, 108, 108))),
                          contentPadding: const EdgeInsets.all(8),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(255, 108, 108, 108))),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      onTap: () {
                        cubit.onSendMessage(ticketId: log?.ticket_id ?? 0);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
