import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/certificate.dart';
import 'package:insuranceapp/features/my_insurance/presentation/cubit/my_insurance_cubit.dart';
import 'package:insuranceapp/generated/assets.dart';

class PaymentPage extends StatelessWidget {
  final Certificate? certificate;
  const PaymentPage({super.key,this.certificate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Payment method"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: const Text("Credit/Debit Card"),
                    leading: Image.asset(Assets.imagesCreditLogo),
                  ),
                ),
                onTap: () {
                  context.read<MyInsuranceCubit>().makePayment(type: PaymentType.CREDIT_CARD,certificate: certificate);
                },
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: const Text("BCELOne Pay"),
                    leading: Image.asset(Assets.imagesBcelLogo),
                  ),
                ),
                onTap: () {
                  context
                      .read<MyInsuranceCubit>()
                      .makePayment(type: PaymentType.BCELONE_PAY,certificate: certificate);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
