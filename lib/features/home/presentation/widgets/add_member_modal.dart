// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:insuranceapp/core/constants/constant.dart';
// import 'package:insuranceapp/core/utils/app_navigator.dart';
// import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
// import 'package:insuranceapp/core/widgets/forms/pt_dropdown_field.dart';
// import 'package:insuranceapp/features/home/presentation/cubit/insurance/insurance_state.dart';
// import 'package:insuranceapp/features/home/presentation/widgets/add_image_widget.dart';
// import 'package:insuranceapp/generated/locale_keys.g.dart';

// import '../../../../core/entities/dropdowns.dart';
// import '../../../../core/widgets/forms/pt_date_picker_field.dart';
// import '../cubit/insurance/insurance_cubit.dart';

// class AddMemberModal extends StatelessWidget {
//   const AddMemberModal({super.key});

//   @override
//   Widget build(BuildContext context) {
//     List<Dropdowns> listGender = [
//       Dropdowns(
//         name: LocaleKeys.kMale.tr(),
//         value: "MALE",
//       ),
//       Dropdowns(
//         name: LocaleKeys.kFemale.tr(),
//         value: "FEMALE",
//       ),
//       Dropdowns(
//         name: LocaleKeys.kOther.tr(),
//         value: "Other",
//       ),
//     ];
//     final cubit = context.read<InsuranceCubit>();
//     return Scaffold(
//       body: BlocConsumer<InsuranceCubit, InsuranceState>(
//         listener: (context, state) {
//           if (state.status == InsuranceStatus.FAILURE) {
//             Fluttertoast.showToast(msg: state.error.toString());
//           }
//         },
//         builder: (context, state) {
//           return Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     TextButton(
//                       onPressed: () => AppNavigator.goBack(),
//                       child: const Icon(
//                         Icons.close,
//                         size: 25,
//                         color: Colors.black,
//                       ),
//                     ),
//                     Text(LocaleKeys.kAddMember.tr()),
//                     TextButton(
//                       onPressed: () async {
//                         await cubit.addMember();
//                       },
//                       child: Text(LocaleKeys.kSave.tr()),
//                     )
//                   ],
//                 ),
//               ),
//               const Divider(),
//               Expanded(
//                   child: SingleChildScrollView(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 20),
//                   child: FormBuilder(
//                     key: cubit.formMemberKey,
//                     child: Column(
//                       children: [
//                         PTCustomTextField(
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           name: 'firstname',
//                           decoration: InputDecoration(
//                             labelText: LocaleKeys.kFirstName.tr(),
//                           ),
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required<String>(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                         ),
//                         PTCustomTextField(
//                           name: 'lastname',
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           decoration: InputDecoration(
//                             labelText: LocaleKeys.kLastName.tr(),
//                           ),
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required<String>(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                         ),
//                         PTDropdownField<Dropdowns>(
//                           name: 'gender',
//                           decoration: InputDecoration(
//                               labelText: "${LocaleKeys.kGender.tr()} *"),
//                           source: listGender,
//                           valueTransformer: (Dropdowns? value) => value?.value,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                         ),
//                         const SizedBox(height: 15),
//                         PTDatePickerField(
//                           name: 'dob',
//                           inputType: InputType.date,
//                           valueTransformer: (value) => value?.toIso8601String(),
//                           decoration: InputDecoration(
//                               labelText: LocaleKeys.kDOB.tr(),
//                               suffixIcon:
//                                   const Icon(Icons.date_range_outlined)),
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                         ),
//                         PTCustomTextField(
//                           name: 'passport',
//                           autovalidateMode: AutovalidateMode.onUserInteraction,
//                           decoration: InputDecoration(
//                             labelText: LocaleKeys.kPassportNo.tr(),
//                           ),
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required<String>(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                         ),
//                         PTDropdownField(
//                           name: 'relation',
//                           decoration: InputDecoration(
//                               labelText: LocaleKeys.kRelation.tr()),
//                           source: cubit.listRelation,
//                           validator: FormBuilderValidators.compose([
//                             FormBuilderValidators.required(
//                                 errorText: LocaleKeys.kRequiredField.tr())
//                           ]),
//                           valueTransformer: (Dropdowns? value) => value?.value,
//                         ),
//                         const SizedBox(
//                           height: 15,
//                         ),
//                         AddImageWidget(
//                           description: 'Upload Passport Description',
//                           title: LocaleKeys.kPassportNo.tr(),
//                           fileType: FileType.passport,
//                         ),
//                         AddImageWidget(
//                           description: 'Upload vaccine card photo',
//                           title: LocaleKeys.kVaccine.tr(),
//                           fileType: FileType.vaccine,
//                         ),
//                         AddImageWidget(
//                           description: 'Upload RTPCR card photo',
//                           title: LocaleKeys.kRTPCR.tr(),
//                           fileType: FileType.rtpcr,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ))
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
