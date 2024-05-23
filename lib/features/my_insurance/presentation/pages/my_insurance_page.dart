import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/my_insurance_cubit.dart';

class MyInsurancePage extends StatelessWidget {
  const MyInsurancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kMyInsurance.tr()),
      ),
      body: BlocBuilder<MyInsuranceCubit, MyInsuranceState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: state.listCertificate.map((item) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding:
                            const EdgeInsets.only(top: 10, bottom: 10),
                        leading: Container(
                          padding: const EdgeInsets.all(5),
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Utils.getPaymentColorByStatus(
                                item.status ?? ''),
                          ),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Utils.formatDateF('dd/MM', item.createdtime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  Utils.formatDateF('yyyy', item.createdtime),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        title: Text(
                          item.no ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${item.insurancetype!.name!} > ${item.insurancepackage!.name!}'),
                            Text(item.type == 'SINGLE'
                                ? LocaleKeys.kSingle.tr().toUpperCase()
                                : LocaleKeys.kFamily.tr().toUpperCase()),
                          ],
                        ),
                        trailing: SizedBox(
                          width: 70,
                          child: Column(
                            children: [
                              Text(
                                '${Utils.formatNumber(item.amount ?? 0)} ₭',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  color: Utils.getPaymentColorByStatus(
                                      item.status!),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Utils.getPaymentColorByStatus(
                                      item.status!),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: const EdgeInsets.only(
                                    left: 4, right: 4, top: 4, bottom: 4),
                                margin: const EdgeInsets.only(top: 4),
                                child: Text(
                                  item.status!,
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: Colors.white,
                                    backgroundColor:
                                        Utils.getPaymentColorByStatus(
                                            item.status!),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          AppNavigator.navigateTo(AppRoute.myInsuranceDetail,
                              params: item);
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
      ),
    );
  }
}
