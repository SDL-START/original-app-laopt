import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/core/widgets/pt_custom_button.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/widgets/forms/pt_custom_textfield.dart';
import '../cubit/login_cubit.dart';

class LoginDetail extends StatelessWidget {
  final bool isPhone;
  const LoginDetail({
    super.key,
    this.isPhone = false,
  });
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final String title = isPhone
        ? LocaleKeys.kLoginWithPhone.tr()
        : LocaleKeys.kLoginWithEmail.tr();
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status == DataStatus.failure) {
          Fluttertoast.showToast(msg: state.error ?? '');
        }
      },
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(title),
          ),
          body: Form(
            key: context.read<LoginCubit>().formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 30),
                    (!isPhone)
                        ? PTCustomTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            initialValue: state.loginData?.email,
                            controller:
                                context.read<LoginCubit>().emailController,
                            name: 'email',
                            decoration: InputDecoration(
                                // labelText: LocaleKeys.KLoginEmail.tr(),
                                ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required<String>(
                                  errorText: LocaleKeys.kRequiredField.tr())
                            ]),
                          )
                        : IntlPhoneField(
                            initialCountryCode: cubit.codeString,
                            initialValue: cubit.phoneNumber,
                            disableLengthCheck: true,
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.kPhone.tr(),
                              errorText: state.validated
                                  ? null
                                  : LocaleKeys.kRequiredField.tr(),
                            ),
                            onChanged: (value) {
                              cubit.onChangedPhoneNumber(value);
                            },
                            onCountryChanged: (country) {
                              cubit.codeNumber = country.dialCode;
                              cubit.codeString = country.code;
                            },
                            validator: (value) {
                              if (value?.number == null ||
                                  value?.number == "") {
                                return LocaleKeys.kRequiredField.tr();
                              } else {
                                return null;
                              }
                            }),
                    PTCustomTextField(
                      obscureText: true,
                      controller: context.read<LoginCubit>().passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'password',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kPassword.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required<String>(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    FormBuilderCheckbox(
                      initialValue: state.rememberMe,
                      name: "remember",
                      title: Text(
                        LocaleKeys.kRememberMe.tr(),
                      ),
                      onChanged: (value) {
                        context
                            .read<LoginCubit>()
                            .onChangedRememberMe(value ?? false);
                      },
                    ),
                    const SizedBox(height: 15),
                    PTCustomButton(
                      label: LocaleKeys.kLogin.tr(),
                      onTap: () {
                        context.read<LoginCubit>().login(isPhone: isPhone);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        AppNavigator.navigateTo(AppRoute.forgotPasswordRoute);
                      },
                      child: Text(LocaleKeys.kForgotPassword.tr()),
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
