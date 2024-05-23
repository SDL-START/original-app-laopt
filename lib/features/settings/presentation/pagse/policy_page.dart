import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/params/buyinsurance_params.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/utils/utils.dart';

class PolicyPage extends StatelessWidget {
  final BuyInsuranceParams? buyInsuranceParams;
  const PolicyPage({super.key, this.buyInsuranceParams});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kPolicy.tr()),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return Padding(
            padding: const EdgeInsets.all(10),
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: Uri.parse(
                  '${APIPath.baseUrl}/policy-${Utils.convertCode(context: context)}.html?1=1',
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: (buyInsuranceParams?.isHome == true)
          ? null
          : FloatingActionButton.extended(
              onPressed: buyInsuranceParams?.onPressed,
              label: Text(LocaleKeys.kAcceptedTerms.tr()),
            ),
    );
  }
}
