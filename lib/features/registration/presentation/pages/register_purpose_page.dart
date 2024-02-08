import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/forms/pt_date_picker_field.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/registration/presentation/cubit/register_cubit.dart';
import 'package:insuranceapp/features/registration/presentation/cubit/register_state.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/entities/dropdowns.dart';
import '../../../../core/widgets/forms/pt_dropdown_field.dart';

class RegisterPurposePage extends StatelessWidget {
  const RegisterPurposePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register - Purpose"),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.PURPOSED) {
            AppNavigator.navigateTo(AppRoute.setPasswordRoute,params: cubit);
          }
        },
        builder: (context, state) {
          if (state.status == RegisterStatus.LOADING) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: FormBuilder(
                key: cubit.formPurpose,
                child: Column(
                  children: [
                    PTCustomTextField(
                      name: 'firstname',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kFirstName.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTCustomTextField(
                      name: 'lastname',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kLastName.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTDropdownField<Dropdowns>(
                      name: 'gender',
                      decoration:
                          InputDecoration(labelText: LocaleKeys.kGender.tr()),
                      source: cubit.listGender,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (Dropdowns? value) => value?.value,
                    ),
                    PTDatePickerField(
                      name: 'dateofbirth',
                      inputType: InputType.date,
                      decoration: InputDecoration(
                          labelText: LocaleKeys.kDOB.tr(),
                          suffixIcon: const Icon(Icons.date_range)),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (value) => value?.toIso8601String(),
                    ),
                    PTCustomTextField(
                      name: 'passport',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kPassportNo.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTCustomTextField(
                      name: 'city',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kCity.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTCustomTextField(
                      name: 'address',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kAddress.tr(),
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTDropdownField<Dropdowns>(
                      name: 'purpose',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kPurposeOfVisit.tr(),
                      ),
                      source: cubit.listPurposes,
                      valueTransformer: (Dropdowns? value) => value?.value,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    PTDropdownField<Dropdowns>(
                      name: 'provinceid',
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kProvince.tr(),
                      ),
                      source: cubit.listProvinces,
                      valueTransformer: (Dropdowns? value) => value?.value,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          cubit.onSubmitPurpose();
        },
        label: Text(
          LocaleKeys.kNext.tr(),
        ),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
