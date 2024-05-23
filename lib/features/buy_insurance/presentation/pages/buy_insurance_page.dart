import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../cubit/buy_insurance_cubit.dart';

class BuyInsurancePage extends StatelessWidget {
  const BuyInsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.kBuyInsurance.tr(),
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
                children: state.listInsurance.map((item) {
                  return Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.red,
                      ),
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(5),
                        child: CachedNetworkImage(
                          imageUrl: item.photo??'',
                          width: 100,
                        ),
                      ),
                      title: Text(item.name!),
                      subtitle: Text(item.description ?? '-'),
                      onTap: () {
                        AppNavigator.navigateTo(AppRoute.selectPackageRoute,params: item);
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
