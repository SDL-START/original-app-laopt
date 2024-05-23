import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/cubit/buy_insurance_cubit.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/utils.dart';
import '../../../../generated/locale_keys.g.dart';

class PolicyShedulePage extends StatelessWidget {
  const PolicyShedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kPolicy.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(
                '${APIPath.baseUrl}/policy-${Utils.convertCode(context: context)}.html?1=1'),
          ),
        ),
      ),
      floatingActionButton: BlocBuilder<BuyInsuranceCubit, BuyInsuranceState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.primaryColor),
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return FloatingActionButton.extended(
            onPressed: () async {
              await context.read<BuyInsuranceCubit>().createCertificate();
            },
            label: Text(LocaleKeys.kAcceptedTerms.tr()),
          );
        },
      ),
    );
  }
}
