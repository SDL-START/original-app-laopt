import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../core/constants/constant.dart';
import '../../../../../core/utils/app_navigator.dart';
import '../../../../../core/utils/router.dart';
import '../../../../../core/widgets/forms/pt_custom_textfield.dart';
import '../../cubit/login_cubit.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kForgotPassword.tr()),
      ),
      body: BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: cubit.formForgotKey,
            child: Column(
              children: [
                RadioListTile<ValidateType>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(LocaleKeys.kPhone.tr()),
                  groupValue: state.forgotType,
                  onChanged: (value) {
                    cubit.onChangedType(value: value);
                  },
                  value: ValidateType.PHONE,
                ),
                const SizedBox(height: 10),
                if (state.forgotType == ValidateType.PHONE) ...[
                  IntlPhoneField(
                      disableLengthCheck: true,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.kPhone.tr(),
                        errorText: state.validated
                            ? null
                            : LocaleKeys.kRequiredField.tr(),
                      ),
                      onChanged: (value) {
                        context.read<LoginCubit>().onChangedPhoneNumber(value);
                      },
                      onCountryChanged: (country) {
                        context.read<LoginCubit>().onChangedPhoneCountryr(country);
                      },
                      validator: (value) {
                        if (value?.number == null || value?.number == "") {
                          return LocaleKeys.kRequiredField.tr();
                        } else {
                          return null;
                        }
                      }),
                ],
                RadioListTile<ValidateType>(
                  contentPadding: EdgeInsets.zero,
                  title: Text(LocaleKeys.kEmail.tr()),
                  groupValue: state.forgotType,
                  onChanged: (value) {
                    cubit.onChangedType(value: value);
                  },
                  value: ValidateType.EMAIL,
                ),
                if (state.forgotType == ValidateType.EMAIL) ...[
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: PTCustomTextField(
                      name: 'email',
                      controller: context.read<LoginCubit>().emailController,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kEmail.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr()),
                        FormBuilderValidators.email(
                            errorText: "example: name@abc.com")
                      ]),
                    ),
                  ),
                ]
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if(state.status == DataStatus.failure){
          Fluttertoast.showToast(msg: state.error??'');
        }else if(state.status == DataStatus.success){
          AppNavigator.navigateTo(AppRoute.resetPasswordRoute,params: cubit);
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.forgotRequest();
        },
        label: Text(LocaleKeys.kNext.tr()),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
