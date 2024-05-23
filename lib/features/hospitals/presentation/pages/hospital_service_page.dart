import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/hospitals/presentation/cubit/hospital_cubit.dart';
import 'package:insuranceapp/features/hospitals/presentation/pages/tabs/hospital_tab.dart';
import 'package:insuranceapp/features/hospitals/presentation/pages/tabs/service_unit_tab.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class HospitalServicePage extends StatelessWidget {
  const HospitalServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.kHospitalAndService.tr()),
          bottom: TabBar(
            indicatorColor: Colors.red,
            tabs: [
              Tab(text: LocaleKeys.kHospital.tr()),
              Tab(text: LocaleKeys.kServiceUnits.tr()),
            ],
          ),
        ),
        body: BlocBuilder<HospitalCubit, HospitalState>(
          builder: (context, state) {
            if(state.status == DataStatus.loading){
              return const LoadingWidget();
            }
            return TabBarView(
              children: [
                HospitalTab(
                  listHospital:
                      state.hospitals.where((e) => e.type == "1").toList(),
                ),
                ServiceUnitTab(
                    listHospital:
                        state.hospitals.where((e) => e.type == "2").toList()),
              ],
            );
          },
        ),
      ),
    );
  }
}
