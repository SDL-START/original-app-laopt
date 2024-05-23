import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/app_images.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/widgets/failure_widget.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/router.dart';
import '../../../../core/utils/utils.dart';
import '../cubit/support_cubit/support_cubit.dart';

class ListTicketPage extends StatelessWidget {
  const ListTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kListTicket.tr()),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.backGround), fit: BoxFit.cover),
        ),
        child: BlocBuilder<SupportCubit, SupportState>(
          builder: (context, state) {
            if (state.status == DataStatus.loading) {
              return const LoadingWidget();
            } else if (state.status == DataStatus.failure) {
              return const FailureWidget();
            }
            return Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: state.listTicket?.map((ticket) {
                        return Card(
                          color: Colors.white.withOpacity(0.7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ListTile(
                            leading: Container(
                              height: double.infinity,
                              color: Utils.getSosColorByStatus(
                                  ticket.status ?? ''),
                              width: 2,
                            ),
                            minLeadingWidth: 2,
                            textColor: Colors.black,
                            minVerticalPadding: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            title: Text(
                              "TicketID: ${ticket.ticketId}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(3),
                                    color: Utils.getSosColorByStatus(
                                        ticket.status ?? ''),
                                    child: Text("Status: ${ticket.status}"),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text("Description: ${ticket.description}")
                                ],
                              ),
                            ),
                            trailing: SizedBox(
                              width: 130,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(Icons.access_time_outlined),
                                  const SizedBox(width: 5),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(Utils.formatDate(ticket.updatedAt
                                          ?.toLocal()
                                          .toIso8601String())),
                                      Text(Utils.formatTime(ticket.createdAt
                                          ?.toLocal()
                                          .toIso8601String())),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              if (ticket.status == TicketStatus.inprogress) {
                                AppNavigator.navigateTo(
                                  AppRoute.chatRoute,
                                  params: ticket,
                                );
                              } else {
                                AppNavigator.navigateTo(
                                  AppRoute.ticketDetailRoute,
                                  params: ticket,
                                );
                              }
                            },
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
