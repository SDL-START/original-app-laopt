// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:insuranceapp/core/utils/utils.dart';
// import 'package:insuranceapp/core/widgets/loading_widget.dart';
// import 'package:insuranceapp/features/chats/domain/usecases/get_ticket_detail_usecase.dart';
// import 'package:insuranceapp/features/chats/presentation/cubit/chat_cubit.dart';
// import 'package:insuranceapp/features/chats/presentation/cubit/chat_state.dart';
// import 'package:insuranceapp/generated/locale_keys.g.dart';
// import 'package:url_launcher/url_launcher.dart';

// import '../../../../core/widgets/build_item.dart';

// class TicketDetailPage extends StatelessWidget {
//   final GetTicketDetailParams params;
//   const TicketDetailPage({super.key, required this.params});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         // title: Text("#${params.ticket?.ticket_id}"),
//       ),
//       body: BlocBuilder<ChatCubit, ChatState>(
//         builder: (context, state) {
//           if (state.status == ChatStatus.LOADING) {
//             return const LoadingWidget();
//           }
//           return SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   if (params.ticket?.status == "PENDING" ||
//                       params.ticket?.status == "CANCELLED") ...[
//                     BuildItem(
//                       label: LocaleKeys.kDateTime.tr(),
//                       // value: Utils.formatDate(
//                       //     params.ticket?.create_at?.toIso8601String()),
//                     ),
//                     const SizedBox(height: 20),
//                     BuildItem(
//                       label: LocaleKeys.kStatus.tr(),
//                       value: params.ticket?.status,
//                     ),
//                   ],
//                   if (params.ticket?.status != "PENDING" &&
//                       params.ticket?.status != "CANCELLED") ...[
//                     BuildItem(
//                       label: LocaleKeys.kDateTime.tr(),
//                       value: Utils.formatDate(
//                         state.ticketLog?.confirm_date?.toIso8601String(),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     BuildItem(
//                       label: LocaleKeys.kStatus.tr(),
//                       value: state.ticketLog?.status,
//                     ),
//                     const SizedBox(height: 20),
//                     BuildItem(
//                       label: LocaleKeys.kName.tr(),
//                       value:
//                           "${state.ticketLog?.user?.firstname??''} ${state.ticketLog?.user?.lastname??''}",
//                     ),
//                     const SizedBox(height: 20),
//                     BuildItem(
//                       label: LocaleKeys.kTel.tr(),
//                       value: state.ticketLog?.user?.phone,
//                     ),
//                     const SizedBox(height: 20),
//                     BuildItem(
//                       label: LocaleKeys.kEmail.tr(),
//                       value: state.ticketLog?.user?.email,
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: double.infinity,
//                             margin: const EdgeInsets.only(bottom: 16),
//                             child: OutlinedButton(
//                               onPressed: () async {
//                                 await launchUrl(Uri.parse(
//                                     "tel:${state.ticketLog?.user?.phone}"));
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 side: const BorderSide(color: Colors.red),
//                               ),
//                               child: Text(LocaleKeys.kCall.tr()),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 15),
//                         Expanded(
//                           child: Container(
//                             width: double.infinity,
//                             margin: const EdgeInsets.only(bottom: 16),
//                             child: OutlinedButton(
//                               onPressed: () async {
//                                 await launchUrl(Uri.parse(
//                                     "sms:${state.ticketLog?.user?.phone}"));
//                               },
//                               style: OutlinedButton.styleFrom(
//                                 side: const BorderSide(color: Colors.red),
//                               ),
//                               child: Text(LocaleKeys.kMessage.tr()),
//                             ),
//                           ),
//                         )
//                       ],
//                     )
//                   ]
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
