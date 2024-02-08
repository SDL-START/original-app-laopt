import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../core/constants/app_images.dart';
import '../../../../../core/constants/constant.dart';
import '../../../../../core/utils/app_navigator.dart';
import '../../../../../core/utils/router.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../../../generated/locale_keys.g.dart';
import '../../cubit/chat_cubit/chat_cubit.dart';
import '../../widgets/message_bubble.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            previous.listMessage != current.listMessage||
            previous.canSend != current.canSend ||
            previous.status != current.status,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leadingWidth: 20,
              title: InkWell(
                onTap: () {
                  if (state.currentUser?.role == "STAFF") {
                    AppNavigator.navigateTo(
                      AppRoute.sosDetail,
                      params: state.ticket?.ticketId,
                    );
                  } else {
                    AppNavigator.navigateTo(
                      AppRoute.ticketDetailRoute,
                      params: state.ticket,
                    );
                  }
                },
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage(
                        AppImages.support,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        state.currentUser?.role == "STAFF"
                            ? Text(
                                "${state.ticket?.user?.firstname??''} ${state.ticket?.user?.lastname??''}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              )
                            : Text(
                                "${state.ticket?.sosInfo?.user?.firstname??''} ${state.ticket?.sosInfo?.user?.lastname??''}",
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   children: [
                        //     const Icon(Icons.pin_drop_outlined, size: 10),
                        //     Text(
                        //       "${state.distance} Km",
                        //       style: const TextStyle(
                        //           fontSize: 10, color: Colors.white),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ],
                )
              ),
              actions: [
                state.currentUser?.role == "STAFF"
                    ? Container()
                    : TextButton(
                        onPressed: () {
                          AppNavigator.showOptionDialog(
                              title: Text(
                                LocaleKeys.kWarnning.tr(),
                              ),
                              content: Text(
                                LocaleKeys.kCancelTicket.tr(),
                              ),
                              action: () async {
                                AppNavigator.goBack();
                                await cubit.userCanel(
                                    ticketId: state.ticket?.ticketId ?? 0);
                              });
                        },
                        child: Text(
                          LocaleKeys.kCancel.tr(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
              ],
            ),
            body: Builder(builder: (context) {
              if (state.status == DataStatus.loading) {
                return const LoadingWidget();
              } else if (state.status == DataStatus.failure) {
                return Container();
              }
              cubit.scrollToEnd();
              return Column(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        cubit.focusNode.unfocus();
                      },
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        controller: cubit.scrollController,
                        child: Column(
                          children: state.listMessage?.map((message) {
                                return MessageBubble(
                                  message: message,
                                  isUserMessage: context
                                      .read<ChatCubit>()
                                      .isUserMessage(userId: message.senderId),
                                  isStaff: state.currentUser?.role == "STAFF",
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  //Textfield message
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, bottom: 20, top: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: const Icon(Icons.add),
                          onTap: () {
                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    actions: [
                                      CupertinoActionSheetAction(
                                        onPressed: () async {
                                          AppNavigator.goBack();
                                          await cubit
                                              .getImage(ImageSource.camera);
                                        },
                                        child: Text(LocaleKeys.kCamera.tr()),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () async {
                                          AppNavigator.goBack();
                                          await cubit
                                              .getImage(ImageSource.gallery);
                                        },
                                        child: Text(LocaleKeys.kGallery.tr()),
                                      ),
                                      CupertinoActionSheetAction(
                                        onPressed: () {
                                          AppNavigator.goBack();
                                          AppNavigator.navigateTo(
                                            AppRoute.sendLocationRoute,
                                            params: state.ticket,
                                          );
                                        },
                                        child: Text(LocaleKeys.kLocation.tr()),
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text(
                                        LocaleKeys.kCancel.tr(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        AppNavigator.goBack();
                                      },
                                    ),
                                  );
                                });
                          },
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            focusNode: cubit.focusNode,
                            controller: cubit.messageTextController,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 16),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(
                                  top: 5, bottom: 5, left: 5, right: 10),
                              isDense: true,
                              hintText: "Message",
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 0.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: (state.canSend)
                              ? () async {
                                  await context.read<ChatCubit>().sendMessage(
                                        ticketId: state.ticket?.ticketId,
                                        receiverId:
                                            state.ticket?.sosInfo?.user?.id,
                                      );
                                }
                              : null,
                          child: const Text('Send'),
                        )
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        });
  }
}
