import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_phone_filed.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kRegister.tr()),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.REQUESTED) {
            AppNavigator.navigateTo(AppRoute.confirmOTP, params: cubit);
          } else if (state.status == RegisterStatus.FAILURE) {
            Fluttertoast.showToast(msg: state.error??"");
          }
        },
        builder: (context, state) {
          return BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              if (state.status == RegisterStatus.LOADING) {
                return const LoadingWidget();
              }
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: FormBuilder(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      RadioListTile<ValidateType>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(LocaleKeys.kPhone.tr()),
                        groupValue: cubit.type,
                        onChanged: (value) {
                          cubit.onChangedType(value: value);
                        },
                        value: ValidateType.PHONE,
                      ),
                      const SizedBox(height: 10),
                      if (cubit.type == ValidateType.PHONE) ...[
                        PTCustomPhoneField(
                          name: 'phone',
                          initialCountryCode: "LA",
                          disableLengthCheck: true,
                          valueTransformer: (phone) => phone?.completeNumber,
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(
                                errorText: LocaleKeys.kRequiredField.tr())
                          ]),
                        )
                      ],
                      RadioListTile<ValidateType>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(LocaleKeys.kEmail.tr()),
                        groupValue: cubit.type,
                        onChanged: (value) {
                          cubit.onChangedType(value: value);
                        },
                        value: ValidateType.EMAIL,
                      ),
                      if (cubit.type == ValidateType.EMAIL) ...[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: PTCustomTextField(
                            initialValue: cubit.formValue['email'],
                            name: 'email',
                            decoration: InputDecoration(
                              labelText: LocaleKeys.kEmail.tr(),
                            ),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                  errorText: LocaleKeys.kRequiredField.tr())
                            ]),
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.requestRegister();
        },
        label: Text(LocaleKeys.kNext.tr()),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
