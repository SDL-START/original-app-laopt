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
import 'package:insuranceapp/features/registration/presentation/cubit/register_cubit.dart';
import 'package:insuranceapp/features/registration/presentation/cubit/register_state.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/utils.dart';

class SetPasswordPage extends StatelessWidget {
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kSetPassword.tr()),
      ),
      body: FormBuilder(
        key: cubit.formPassword,
        child: BlocConsumer<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state.status == RegisterStatus.VALIDAT_FAILE) {
              Fluttertoast.showToast(msg: "Password is not matched");
            } else if (state.status == RegisterStatus.REGISTER_SUCCESS) {
              Fluttertoast.showToast(msg: "Register success");
              AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
            }
          },
          builder: (context, state) {
            if (state.status == RegisterStatus.LOADING) {
              return const LoadingWidget();
            }
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    PTCustomTextField(
                      obscureText: true,
                      name: 'newpassword',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (value) =>
                          Utils.hash(value: value ?? ''),
                    ),
                    PTCustomTextField(
                      obscureText: true,
                      name: 'confirmpassword',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kConfirmPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (value) =>
                          Utils.hash(value: value ?? ''),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.registerPassword();
        },
        label: Text(
          LocaleKeys.kSave.tr(),
        ),
      ),
    );
  }
}
