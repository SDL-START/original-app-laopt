import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/claim.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/build_item.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/assets.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/claim_cubit.dart';

class ClaimDetailPage extends StatelessWidget {
  final Claim claim;
  const ClaimDetailPage({
    super.key,
    required this.claim,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kClaimDetal.tr()),
      ),
      body: BlocBuilder<ClaimCubit, ClaimState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  BuildItem(
                    label: LocaleKeys.kClaimID.tr(),
                    value: "${claim.id ?? ""}",
                  ),
                  const SizedBox(height: 15),
                  BuildItem(
                    label: LocaleKeys.kCertificateNo.tr(),
                    value: "${claim.certificate?.no}",
                  ),
                  const SizedBox(height: 15),
                  BuildItem(
                    label: LocaleKeys.kMember.tr(),
                    value:
                        "${claim.certificatemember?.firstname} ${claim.certificatemember?.lastname}",
                  ),
                  const SizedBox(height: 15),
                  BuildItem(
                    label: LocaleKeys.kClaimType.tr(),
                    value: "${claim.type}",
                  ),
                  const SizedBox(height: 15),
                  BuildItem(
                    label: LocaleKeys.kAmount.tr(),
                    value: '${Utils.formatNumber(claim.amount)} LAK',
                  ),
                  const SizedBox(height: 15),
                  BuildItem(
                    label: LocaleKeys.kStatus.tr(),
                    value: '${claim.status}',
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    height: 150,
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: claim.photo?.length ?? 0,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final url = claim.photo?[index] as String;
                        return CachedNetworkImage(
                          imageUrl: Utils.onGenerateImageUrl(url: url),
                          width: 140,
                          height: 140,
                          fit: BoxFit.contain,
                          placeholder: (context, url) {
                            return Image.asset(
                              Assets.imagesPlaceholderImage,
                              width: 140,
                              height: 140,
                              fit: BoxFit.contain,
                            );
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(
                              Assets.imagesPlaceholderImage,
                              width: 140,
                              height: 140,
                              fit: BoxFit.contain,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    color: Colors.grey.shade200,
                    child: Text(
                      LocaleKeys.kHistory.tr(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: state.listClaimLog.map((log) {
                      return ListTile(
                        title: Text(
                          Utils.formatDateTime(
                            log.txtime?.toIso8601String(),
                          ),
                        ),
                        subtitle: Text(log.remark ?? ""),
                        trailing: Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, top: 4, bottom: 4),
                          decoration: BoxDecoration(
                            color:
                                Utils.getPaymentColorByStatus(log.status ?? ''),
                          ),
                          child: Text(
                            log.status ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
