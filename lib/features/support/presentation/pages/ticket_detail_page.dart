import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/extensions/date_time_extension.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/widgets/build_item.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../../generated/locale_keys.g.dart';
import '../cubit/support_cubit/support_cubit.dart';

class TicketDetailPage extends StatelessWidget {
  const TicketDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupportCubit, SupportState>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.kTicketDetail.tr()),
          centerTitle: true,
          actions: [
            if (state.currentUser?.role != "STAFF" &&
                state.ticket?.status == TicketStatus.pending) ...[
              TextButton(
                onPressed: () {
                  AppNavigator.showOptionDialog(
                      title: Text(LocaleKeys.kWarnning.tr()),
                      content: Text(LocaleKeys.kCancelTicket.tr()),
                      action: () async {
                        AppNavigator.goBack();
                        await context
                            .read<SupportCubit>()
                            .userCancel(ticketId: state.ticket?.ticketId ?? 0);
                      });
                },
                child: Text(
                  LocaleKeys.kCancel.tr(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ]
          ],
        ),
        body: Builder(
          builder: (context) {
            if (state.status == DataStatus.loading) {
              return const LoadingWidget();
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  if (state.ticket?.status == TicketStatus.pending ||
                      state.ticket?.status == TicketStatus.canceled) ...[
                    BuildItem(
                      label: LocaleKeys.kDateTime.tr(),
                      value: state.ticket?.updatedAt.formatDatetimeShort(),
                    ),
                    const SizedBox(height: 20),
                    BuildItem(
                      label: LocaleKeys.kStatus.tr(),
                      value: state.ticket?.status,
                    ),
                  ],
                  if (state.ticket?.status == TicketStatus.completed ||
                      state.ticket?.status == TicketStatus.inprogress) ...[
                    BuildItem(
                      label: LocaleKeys.kDateTime.tr(),
                      value: state.ticket?.updatedAt.formatDatetimeShort(),
                    ),
                    const SizedBox(height: 20),
                    BuildItem(
                      label: LocaleKeys.kStatus.tr(),
                      value: state.ticket?.status,
                    ),
                    const SizedBox(height: 20),
                    BuildItem(
                      label: LocaleKeys.kName.tr(),
                      value: (state.currentUser?.role == "STAFF")
                          ? "${state.ticket?.user?.firstname} ${state.ticket?.user?.lastname}"
                          : "${state.ticket?.sosInfo?.user?.firstname ?? ''} ${state.ticket?.sosInfo?.user?.lastname ?? ''}",
                    ),
                    const SizedBox(height: 20),
                    BuildItem(
                      label: LocaleKeys.kTel.tr(),
                      value: (state.currentUser?.role == "STAFF")
                          ? state.ticket?.user?.phone ?? '-'
                          : state.ticket?.sosInfo?.user?.phone,
                    ),
                    const SizedBox(height: 20),
                    BuildItem(
                      label: LocaleKeys.kEmail.tr(),
                      value: (state.currentUser?.role == "STAFF")
                          ? state.ticket?.user?.email ?? '-'
                          : state.ticket?.sosInfo?.user?.email,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: OutlinedButton(
                              onPressed: () async {
                                if (state.currentUser?.role == "STAFF") {
                                  await launchUrl(Uri.parse(
                                      "tel:${state.ticket?.user?.phone}"));
                                } else {
                                  await launchUrl(Uri.parse(
                                      "tel:${state.ticket?.sosInfo?.user?.phone}"));
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                              ),
                              child: Text(LocaleKeys.kCall.tr()),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 16),
                            child: OutlinedButton(
                              onPressed: () async {
                                if (state.currentUser?.role == "STAFF") {
                                  await launchUrl(Uri.parse(
                                      "sms:${state.ticket?.user?.phone}"));
                                } else {
                                  await launchUrl(Uri.parse(
                                      "sms:${state.ticket?.sosInfo?.user?.phone}"));
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                              ),
                              child: Text(LocaleKeys.kMessage.tr()),
                            ),
                          ),
                        )
                      ],
                    )
                  ]
                ],
              ),
            );
          },
        ),
      );
    });
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(LocaleKeys.kTicketDetail.tr()),
    //     centerTitle: true,
    //     actions: [

    //     ],
    //   ),
    //   body: BlocBuilder<SupportCubit, SupportState>(
    //     builder: (context, state) {
    //       if (state.status == DataStatus.loading) {
    //         return const LoadingWidget();
    //       }
    //       return SingleChildScrollView(
    //         padding: const EdgeInsets.all(20),
    //         child: Column(
    //           children: [
    //             if (state.ticket?.status == TicketStatus.pending ||
    //                 state.ticket?.status == TicketStatus.canceled) ...[
    //               BuildItem(
    //                 label: LocaleKeys.kDateTime.tr(),
    //                 value: state.ticket?.updatedAt.formatDatetimeShort(),
    //               ),
    //               const SizedBox(height: 20),
    //               BuildItem(
    //                 label: LocaleKeys.kStatus.tr(),
    //                 value: state.ticket?.status,
    //               ),
    //             ],
    //             if (state.ticket?.status == TicketStatus.completed ||
    //                 state.ticket?.status == TicketStatus.inprogress) ...[
    //               BuildItem(
    //                 label: LocaleKeys.kDateTime.tr(),
    //                 value: state.ticket?.updatedAt.formatDatetimeShort(),
    //               ),
    //               const SizedBox(height: 20),
    //               BuildItem(
    //                 label: LocaleKeys.kStatus.tr(),
    //                 value: state.ticket?.status,
    //               ),
    //               const SizedBox(height: 20),
    //               BuildItem(
    //                 label: LocaleKeys.kName.tr(),
    //                 value: (state.currentUser?.role == "STAFF")
    //                     ? "${state.ticket?.user?.firstname} ${state.ticket?.user?.lastname}"
    //                     : "${state.ticket?.sosInfo?.user?.firstname ?? ''} ${state.ticket?.sosInfo?.user?.lastname ?? ''}",
    //               ),
    //               const SizedBox(height: 20),
    //               BuildItem(
    //                 label: LocaleKeys.kTel.tr(),
    //                 value: (state.currentUser?.role == "STAFF")
    //                     ? state.ticket?.user?.phone ?? '-'
    //                     : state.ticket?.sosInfo?.user?.phone,
    //               ),
    //               const SizedBox(height: 20),
    //               BuildItem(
    //                 label: LocaleKeys.kEmail.tr(),
    //                 value: (state.currentUser?.role == "STAFF")
    //                     ? state.ticket?.user?.email ?? '-'
    //                     : state.ticket?.sosInfo?.user?.email,
    //               ),
    //               const SizedBox(height: 20),
    //               Row(
    //                 children: [
    //                   Expanded(
    //                     child: Container(
    //                       width: double.infinity,
    //                       margin: const EdgeInsets.only(bottom: 16),
    //                       child: OutlinedButton(
    //                         onPressed: () async {
    //                           if (state.currentUser?.role == "STAFF") {
    //                             await launchUrl(Uri.parse(
    //                                 "tel:${state.ticket?.user?.phone}"));
    //                           } else {
    //                             await launchUrl(Uri.parse(
    //                                 "tel:${state.ticket?.sosInfo?.user?.phone}"));
    //                           }
    //                         },
    //                         style: OutlinedButton.styleFrom(
    //                           side: const BorderSide(color: Colors.red),
    //                         ),
    //                         child: Text(LocaleKeys.kCall.tr()),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(width: 15),
    //                   Expanded(
    //                     child: Container(
    //                       width: double.infinity,
    //                       margin: const EdgeInsets.only(bottom: 16),
    //                       child: OutlinedButton(
    //                         onPressed: () async {
    //                           if (state.currentUser?.role == "STAFF") {
    //                             await launchUrl(Uri.parse(
    //                                 "sms:${state.ticket?.user?.phone}"));
    //                           } else {
    //                             await launchUrl(Uri.parse(
    //                                 "sms:${state.ticket?.sosInfo?.user?.phone}"));
    //                           }
    //                         },
    //                         style: OutlinedButton.styleFrom(
    //                           side: const BorderSide(color: Colors.red),
    //                         ),
    //                         child: Text(LocaleKeys.kMessage.tr()),
    //                       ),
    //                     ),
    //                   )
    //                 ],
    //               )
    //             ]
    //           ],
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
