import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';

import '../../../../core/widgets/empty_widget.dart';
import '../cubit/certificate_cubit.dart';

class ScanCertificatePage extends StatelessWidget {
  const ScanCertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CertificateCubit>();
    return BlocConsumer<CertificateCubit, CertificateState>(
      listener: (context, state) {
        if (state.status == DataStatus.failure) {
          Fluttertoast.showToast(msg: state.error ?? "");
        }
      },
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Scan Certificate'),
          ),
          body: ( state.listScanCertificate.isEmpty)
              ? const EmptyWidget()
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: state.listScanCertificate.map((certificate) {
                        return Card(
                          child: ListTile(
                            title: Text(certificate.certificate?.no ?? ''),
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Utils.getPaymentColorByStatus(
                                      certificate.certificate?.status ?? ''),
                                  shape: BoxShape.circle),
                              child: Center(
                                child: Text(
                                  certificate.certificate?.status ?? '-',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                            subtitle: Text(
                                Utils.formatDateTime(certificate.certificate?.createdtime)),
                            trailing: Text(
                              '₭${Utils.formatNumber(certificate.certificate?.amount)}',
                            ),
                            onTap: () {
                              AppNavigator.navigateTo(
                                  AppRoute.myInsuranceDetail,
                                  params: certificate.certificate);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.qr_code_scanner_outlined),
            onPressed: () async {
              await cubit.onScan();
            },
          ),
        );
      },
    );
  }
}
