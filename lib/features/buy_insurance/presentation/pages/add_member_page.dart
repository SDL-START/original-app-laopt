import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/pages/policy_schedule_page.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/pages/upload_document_page.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../core/utils/app_navigator.dart';
import '../cubit/buy_insurance_cubit.dart';
import '../widgets/add_member_modal.dart';

class AddMemberPage extends StatelessWidget {
  const AddMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BuyInsuranceCubit>();
    return BlocBuilder<BuyInsuranceCubit, BuyInsuranceState>(
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        final totalPrice = state.packagemembers.length *
            double.parse(state.currentPackage?.price ?? "0");
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "${Utils.formatNumber(totalPrice)} LAK",
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  cubit.clearData();
                  AppNavigator.openModal(
                      body: BlocProvider<BuyInsuranceCubit>.value(
                    value: cubit,
                    child: const AddMemberModal(),
                  ));
                },
                child: const Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CheckboxListTile(
                    value: state.includeMe,
                    selected: true,
                    onChanged: (value) {
                      cubit.onChangeIncludeMe(value ?? false);
                    },
                    title: Text(LocaleKeys.kIncludeMe.tr()),
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                  const Divider(),
                  Column(
                    children: state.packagemembers.map((item) {
                      return ListTile(
                        leading: (item.id != null)
                            ? const Icon(
                                Icons.account_circle_outlined,
                                size: 32,
                              )
                            : const Icon(
                                Icons.supervised_user_circle_outlined,
                                size: 32,
                              ),
                        title: Text('${item.firstname} ${item.lastname}'),
                        subtitle: Row(
                          children: [
                            Text(
                                '${LocaleKeys.kDOB.tr()}: ${Utils.formatDate(item.dob?.toIso8601String())}'),
                            const SizedBox(width: 15),
                            Text(item.relation ?? ''),
                          ],
                        ),
                        trailing: (item.id != null)
                            ? const SizedBox.shrink()
                            : InkWell(
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.red,
                                ),
                                onTap: () {
                                  cubit.removeMember(member: item);
                                },
                              ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: (state.packagemembers.isEmpty)
              ? null
              : FloatingActionButton.extended(
                  onPressed: () {
                    if (state.currentUser?.photopassport == null ||
                        state.currentUser?.photopassport == "") {
                      //Upload document
                      cubit.clearDocument();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<BuyInsuranceCubit>.value(
                            value: cubit,
                            child: const UploadDocumentPage(),
                          ),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              BlocProvider<BuyInsuranceCubit>.value(
                            value: cubit,
                            child: const PolicyShedulePage(),
                          ),
                        ),
                      );
                    }
                  },
                  label: Row(
                    children: [
                      const Icon(Icons.arrow_forward),
                      const SizedBox(width: 10),
                      Text(LocaleKeys.kNext.tr()),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
