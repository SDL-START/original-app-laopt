import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/claim/presentation/pages/upload_claim_document_page.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../../core/entities/dropdowns.dart';
import '../../../../../core/widgets/forms/pt_date_picker_field.dart';
import '../../../../core/widgets/forms/pt_dropdown_field.dart';
import '../cubit/claim_cubit.dart';

class RequestClaimPage extends StatelessWidget {
  const RequestClaimPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClaimCubit>();
    print("Hello ----->{$cubit}");
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          LocaleKeys.kClaimRequest.tr(),
        ),
      ),
      body: BlocBuilder<ClaimCubit, ClaimState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return FormBuilder(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    PTDropdownField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kClaimType.tr(),
                      ),
                      name: 'type',
                      enabled: true,
                      source: state.listClaimType
                          .map((e) => Dropdowns(value: e.value, name: e.name))
                          .toList(),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (Dropdowns? value) => value?.value,
                    ),
                    const SizedBox(height: 10),
                    PTDatePickerField(
                      name: 'reqdatetime',
                      inputType: InputType.date,
                      firstDate: DateTime.now()
                          .subtract(const Duration(days: 365 * 100)),
                      decoration: InputDecoration(
                        labelText: LocaleKeys.kDate.tr(),
                        suffixIcon: const Icon(Icons.date_range_rounded),
                      ),
                      valueTransformer: ((value) => value?.toIso8601String()),
                      initialValue: DateTime.now(),
                    ),
                    const SizedBox(height: 10),
                    PTDropdownField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      name: 'hospitalid',
                      decoration: InputDecoration(
                          labelText: LocaleKeys.kHospitalAndService.tr()),
                      source: state.listHospital
                          .map((e) => Dropdowns(
                                value: e.id,
                                name: e.name,
                              ))
                          .toList(),
                      valueTransformer: (Dropdowns? value) => value?.value,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                    ),
                    const SizedBox(height: 15),
                    PTCustomTextField(
                      name: 'amount',
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "${LocaleKeys.kAmount.tr()} (LAK)*",
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                            errorText: LocaleKeys.kRequiredField.tr())
                      ]),
                      valueTransformer: (value) => double.parse(value ?? '0'),
                    ),
                    PTCustomTextField(
                      name: 'description',
                      decoration: const InputDecoration(
                        labelText: "Description",
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (cubit.formKey.currentState!.saveAndValidate()) {
            cubit.onSaveAndValidate();
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider<ClaimCubit>.value(
                  value: cubit,
                  child: const UploadClaimDocumentPage(),
                ),
              ),
            );
          }
        },
        icon: const Icon(Icons.arrow_forward_outlined),
        label: Text(LocaleKeys.kNext.tr()),
      ),
    );
  }
}
