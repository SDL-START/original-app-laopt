import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/empty_widget.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/claim/presentation/pages/request_clain_page.dart';
import 'package:insuranceapp/features/claim/presentation/pages/select_certificate_member_page.dart';
import 'package:insuranceapp/features/claim/presentation/pages/select_certificate_page.dart';
import 'package:insuranceapp/generated/assets.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/claim_cubit.dart';
import 'claim_detail_page.dart';

class ClaimPage extends StatelessWidget {
  const ClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClaimCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kClaim.tr()),
      ),
      body: BlocConsumer<ClaimCubit, ClaimState>(
        listener: (context, state) {
          if (state.status == DataStatus.loaded) {
            if (state.listCertificate.isNotEmpty) {
              if (state.listCertificate.length == 1) {
                if (state.currentCertificate?.certificatemember?.length == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<ClaimCubit>.value(
                      value: cubit
                        ..setCurrentCertificate(state.listCertificate.first)
                        ..setCerrentMember(state
                            .listCertificate.first.certificatemember!.first),
                      child: const RequestClaimPage(),
                    ),
                  ));
                } else {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider<ClaimCubit>.value(
                      value: cubit
                        ..setCurrentCertificate(state.listCertificate.first),
                      child: const SelectCertificateMemberPage(),
                    ),
                  ));
                }
              } else {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider<ClaimCubit>.value(
                      value: cubit,
                      child: const SelectCertificatePage(),
                    ),
                  ),
                );
              }
            } else {
              Fluttertoast.showToast(
                msg: "There is no certificate",
                toastLength: Toast.LENGTH_SHORT,
              );
            }
          }
        },
        builder: (context, state) {
          return BlocBuilder<ClaimCubit, ClaimState>(
            builder: (context, state) {
              if (state.status == DataStatus.loading) {
                return const LoadingWidget();
              } else if (state.listClaim.isEmpty) {
                return const EmptyWidget();
              }
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: state.listClaim.map((item) {
                      return Column(
                        children: [
                          ListTile(
                            leading: CachedNetworkImage(
                              errorWidget: (context, url, error) {
                                return Image.asset(Assets.imagesPlaceholderImage);
                              },
                              imageUrl:
                                  Utils.onGenerateImageUrl(url: item.photo?[0]),
                              width: 60,
                            ),
                            title: Text(
                              Utils.formatDateTime(
                                  item.reqtime?.toIso8601String()),
                            ),
                            subtitle: Text(
                                '${item.type!} ${Utils.formatNumber(item.amount ?? 0)} LAK'),
                            trailing: Container(
                              padding: const EdgeInsets.only(
                                  left: 8, right: 8, top: 4, bottom: 4),
                              decoration: BoxDecoration(
                                color:
                                    Utils.getPaymentColorByStatus(item.status!),
                              ),
                              child: Text(
                                item.status!,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BlocProvider<ClaimCubit>.value(
                                    value: cubit..getClaimLog(id: item.id ?? 0),
                                    child: ClaimDetailPage(
                                      claim: item,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: BlocBuilder<ClaimCubit, ClaimState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const FloatingActionButton(
              onPressed: null,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return FloatingActionButton.extended(
            onPressed: () async {
              await cubit.getPaidInsurance();
            },
            icon: const Icon(Icons.add),
            label: Text(LocaleKeys.kClaimRequest.tr()),
          );
        },
      ),
    );
  }
}
