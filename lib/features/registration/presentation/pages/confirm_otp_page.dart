import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class ConfirmOTPPage extends StatelessWidget {
  const ConfirmOTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kConfirmOTP.tr()),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                cubit.requestRegister();
              },
              child: Text(LocaleKeys.kResend.tr()),
            ),
          )
        ],
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.CONFIRMED) {
            AppNavigator.navigateTo(AppRoute.registerPurposeRoute,
                params: cubit);
          } else if (state.status == RegisterStatus.FAILURE) {
            Fluttertoast.showToast(msg: state.error ?? '');
          }
        },
        builder: (context, state) {
          return BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state.status == RegisterStatus.LOADING) {
                return const LoadingWidget();
              }
              return SingleChildScrollView(
                child: FormBuilder(
                  key: cubit.formOTP,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        PTCustomTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: cubit.otpController,
                          name: 'otp',
                          decoration: const InputDecoration(
                            labelText: 'OTP',
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: LocaleKeys.kRequiredField.tr())
                          ]),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.onConfirmOTP();
        },
        label: Text(LocaleKeys.kNext.tr()),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
