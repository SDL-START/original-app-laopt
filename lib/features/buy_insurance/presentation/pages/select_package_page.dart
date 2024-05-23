import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/buy_insurance_cubit.dart';

class SelectPackagePage extends StatelessWidget {
  const SelectPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.kSelectPackage.tr(),
        ),
      ),
      body: BlocBuilder<BuyInsuranceCubit, BuyInsuranceState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: state.listInsurancePackage.map((item) {
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.only(
                      top: 16,
                      bottom: 16,
                      left: 8,
                      right: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: ListTile(
                      title: Text(item.name ?? '-'),
                      subtitle: Text(item.description ?? '-'),
                      trailing: Text(
                        "${Utils.formatNumber(double.parse(item.price ?? '0'))} LAK/${LocaleKeys.kPerson.tr()}",
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        AppNavigator.navigateTo(AppRoute.addMemberRoute,
                            params: {
                              "package": item,
                              "insurance": state.currentInsurance,
                              "currentUser": state.currentUser,
                            });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
