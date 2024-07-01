import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/features/claim/presentation/pages/request_clain_page.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/utils.dart';
import '../cubit/claim_cubit.dart';

class SelectCertificateMemberPage extends StatelessWidget {
  const SelectCertificateMemberPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClaimCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kSelectCertificateMember.tr()),
      ),
      body: BlocBuilder<ClaimCubit, ClaimState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: state.currentCertificate?.certificatemember
                        ?.map((member) {
                      return ListTile(
                        title: Text('${member.firstname} ${member.lastname}'),
                        subtitle: Text(
                            '${Utils.formatDate(member.dob)} ${member.relation}'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  BlocProvider<ClaimCubit>.value(
                                value: cubit..setCerrentMember(member),
                                child: const RequestClaimPage(),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList() ??
                    [],
              ),
            ),
          );
        },
      ),
    );
  }
}
