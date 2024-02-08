import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../cubit/login_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Reset password"),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: FormBuilder(
              key: cubit.resetFormKey,
              child: Column(
                children: [
                  PTCustomTextField(
                    name: 'otp',
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: LocaleKeys.kConfirmOTP.tr(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: LocaleKeys.kRequiredField.tr())
                    ]),
                  ),
                  const Divider(),
                  PTCustomTextField(
                    obscureText: true,
                    name: 'newPassword',
                    decoration: InputDecoration(
                      labelText: LocaleKeys.kNewPassword.tr(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: LocaleKeys.kRequiredField.tr())
                    ]),
                    valueTransformer: (value) => Utils.hash(value: value ?? ''),
                  ),
                  PTCustomTextField(
                    obscureText: true,
                    name: 'confirm',
                    decoration: InputDecoration(
                      labelText: LocaleKeys.kConfirmPassword.tr(),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(
                          errorText: LocaleKeys.kRequiredField.tr())
                    ]),
                    valueTransformer: (value) => Utils.hash(value: value ?? ''),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {
          // if (state.dataStatus == LoginDataStatus.RESETED) {
          //   // Utils.showFlushBar(
          //   //     context: context, message: 'Reset password success');
          //   AppNavigator.goBack();
          //   AppNavigator.goBack();
          // } else if (state.dataStatus == LoginDataStatus.FAILURE) {
          //   Utils.showFlushBar(context: context, message: state.error);
          // }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.resetPassword();
        },
        label: Text(LocaleKeys.kSave.tr()),
      ),
    );
  }
}
