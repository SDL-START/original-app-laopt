// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:insuranceapp/core/utils/app_navigator.dart';
// import 'package:insuranceapp/core/utils/router.dart';
// import 'package:insuranceapp/core/utils/utils.dart';
// import 'package:insuranceapp/core/widgets/loading_widget.dart';
// import 'package:insuranceapp/features/chats/presentation/cubit/chat_cubit.dart';
// import 'package:insuranceapp/features/chats/presentation/cubit/chat_state.dart';
// import 'package:insuranceapp/generated/assets.dart';
// import 'package:insuranceapp/generated/locale_keys.g.dart';

// import '../../../../core/constants/constant.dart';
// import '../../domain/usecases/get_ticket_detail_usecase.dart';

// class ListTicketPage extends StatelessWidget {
//   const ListTicketPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<ChatCubit>();
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(LocaleKeys.kChat.tr()),
//       ),
//       body: BlocBuilder<ChatCubit, ChatState>(
//         builder: (context, state) {
//           if (state.status == ChatStatus.LOADING) {
//             return const LoadingWidget();
//           }
//           return Stack(
//             children: [
//               Container(
//                 decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(Assets.imagesBg),
//                       fit: BoxFit.cover),
//                 ),
//               ),
//               if (cubit.currentUser?.role != "USER") ...[
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: List.generate(cubit.listLog.length, (index) {
//                         final data = cubit.listLog[index];
//                         return Card(
//                           color: Colors.white.withOpacity(0.7),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: ListTile(
//                             leading: Container(
//                               height: double.infinity,
//                               color: Utils.getSosColorByStatus(
//                                   data.sos_tickets?.status ?? ''),
//                               width: 2,
//                             ),
//                             minLeadingWidth: 2,
//                             textColor: Colors.black,
//                             minVerticalPadding: 15,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             title: Text(
//                               "ID: #${data.ticket_id}",
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold, fontSize: 18),
//                             ),
//                             subtitle: Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(3),
//                                     color: Utils.getSosColorByStatus(
//                                         data.sos_tickets?.status ?? ''),
//                                     child: Text(data.sos_tickets?.status ?? ''),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(data.description ?? '')
//                                 ],
//                               ),
//                             ),
//                             trailing: SizedBox(
//                               width: 130,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Icon(Icons.access_time_outlined),
//                                   const SizedBox(width: 5),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(Utils.formatDate(data.confirm_date
//                                           ?.toIso8601String())),
//                                       Text(Utils.formatTime(data.confirm_date
//                                           ?.toIso8601String())),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             onTap: () {
//                               AppNavigator.navigateTo(AppRoute.chatStaffRoute,params: data);

//                             },
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ],
//               if (cubit.currentUser?.role == "USER") ...[
//                 SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Column(
//                       children: List.generate(state.listTicket.length, (index) {
//                         final data = state.listTicket[index];
//                         return Card(
//                           color: Colors.white.withOpacity(0.7),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: ListTile(
//                             leading: Container(
//                               height: double.infinity,
//                               color:
//                                   Utils.getSosColorByStatus(data.status ?? ''),
//                               width: 2,
//                             ),
//                             minLeadingWidth: 2,
//                             textColor: Colors.black,
//                             minVerticalPadding: 15,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             // title: Text(
//                             //   "ID: #${data.ticket_id}",
//                             //   style: const TextStyle(
//                             //       fontWeight: FontWeight.bold, fontSize: 18),
//                             // ),
//                             subtitle: Padding(
//                               padding: const EdgeInsets.only(top: 8),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(3),
//                                     color: Utils.getSosColorByStatus(
//                                         data.status ?? ''),
//                                     child: Text(data.status ?? ''),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(data.description ?? '')
//                                 ],
//                               ),
//                             ),
//                             trailing: SizedBox(
//                               width: 130,
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Icon(Icons.access_time_outlined),
//                                   const SizedBox(width: 5),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(Utils.formatDate(
//                                           data.createdAt.toString())),
//                                       Text(Utils.formatTime(
//                                           data.createdAt?.toIso8601String())),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             onTap: () {
//                               // if (data.status == TicketStatus.processing) {
//                               //   AppNavigator.navigateTo(AppRoute.chatRoute,
//                               //       params: data);
//                               // } else {
//                               //   AppNavigator.navigateTo(
//                                     // AppRoute.ticketDetailRoute,
//                               //       params:
//                               //           GetTicketDetailParams(ticket: data));
//                               // }
//                             },
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ]
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
