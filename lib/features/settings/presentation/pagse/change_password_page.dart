import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/core/widgets/pt_custom_button.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/utils.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) async {
        if (state.status == DataStatus.failure) {
          Utils.showFlushBar(
            context: context,
            title: "Something went wrong",
            message: state.error,
          );
        } else if (state.status == DataStatus.success) {
          await Utils.showFlushBar(
            context: context,
            type: FlushBarType.SUCCESS,
            title: "Success",
            message: 'Password has been changed',
          ).then((value) => Navigator.pop(context));
        }
      },
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kChangePassword.tr()),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FormBuilder(
                key: cubit.formResetKey,
                child: Column(
                  children: [
                    PTCustomTextField(
                      name: "currentPassword",
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kCurrentPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required<String>(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTCustomTextField(
                      obscureText: true,
                      name: "newPassword",
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kNewPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required<String>(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTCustomTextField(
                      obscureText: true,
                      name: "confirmPassword",
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kConfirmPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required<String>(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    const SizedBox(height: 20),
                    PTCustomButton(
                      label: LocaleKeys.kSave.tr(),
                      onTap: () {
                        cubit.onChagePassword();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
