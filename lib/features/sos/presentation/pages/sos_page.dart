import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';

import '../../../../core/models/photo.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/empty_widget.dart';
import '../cubit/sos_cubit.dart';

class SOSListPage extends StatelessWidget {
  const SOSListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SOS List"),
      ),
      body: BlocBuilder<SosCubit, SosState>(
        buildWhen: (previous, current) =>
            previous.listTicket != current.listTicket,
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          } else if (state.listTicket.isEmpty) {
            return const EmptyWidget(
              message: "There is no ticket",
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: List.generate(state.listTicket.length, (index) {
                final item = state.listTicket[index];
                Photo? photos =
                    (item.user?.photo != null && item.user?.photo != "")
                        ? Photo.fromJson(jsonDecode(item.user!.photo!))
                        : null;
                return Column(
                  children: [
                    ListTile(
                      leading: CachedNetworkImage(
                        width: 50,
                        height: 50,
                        imageUrl:
                            Utils.onGenerateImageUrl(url: photos?.photoprofile),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.person,
                          size: 40,
                        ),
                        placeholder: (context, url) {
                          return Container();
                        },
                      ),
                      title: Text(
                          '${item.user?.firstname} ${item.user?.lastname}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            item.description ??
                                Utils.formatDateTime(
                                  item.createdAt?.toIso8601String(),
                                ),
                          ),
                          Text(context.read<SosCubit>().getLocationDistance(
                              lat: item.lat ?? 0, lng: item.lng ?? 0)),
                        ],
                      ),
                      trailing: Container(
                        color: Utils.getSosColorByStatus(item.status!),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 2, left: 4, right: 4),
                        child: Text(
                          item.status!,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        AppNavigator.navigateTo(
                          AppRoute.sosDetail,
                          params: item.ticketId,
                        );
                      },
                    ),
                    const Divider(),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}
