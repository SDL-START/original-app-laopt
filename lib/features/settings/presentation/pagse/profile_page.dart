import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/entities/dropdowns.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/widgets/forms/pt_custom_textfield.dart';
import 'package:insuranceapp/core/widgets/forms/pt_date_picker_field.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/core/widgets/upload_docs_widget.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/utils.dart';
import '../../../../core/widgets/forms/custom_phone_textfield.dart';
import '../../../../core/widgets/forms/pt_dropdown_field.dart';
import '../widgets/profile_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(LocaleKeys.kProfile.tr()),
          actions: [
            TextButton(
                onPressed: () async {
                  await cubit.onSaveProfile();
                },
                child: Text(
                  LocaleKeys.kSave.tr(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ))
          ],
        ),
        body: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) async {
            if (state.status == DataStatus.failure) {
              Fluttertoast.showToast(msg: state.error ?? '');
            }
          },
          builder: (context, state) {
            return BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) {
                if (state.status == DataStatus.loading) {
                  return const LoadingWidget();
                }
                return SafeArea(
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: FormBuilder(
                            key: cubit.profileKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///Profile widget
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ProfileWidget(
                                      url: state.profilePhoto,
                                      onTap: () {
                                        AppNavigator.showModalPopupPhoto(
                                            context: context,
                                            onCamera: (context) {
                                              AppNavigator.goBack();
                                              cubit.getImage(
                                                  source: ImageSource.camera,
                                                  type: FileType.profile);
                                            },
                                            onGallery: (context) {
                                              AppNavigator.goBack();
                                              cubit.getImage(
                                                  source: ImageSource.gallery,
                                                  type: FileType.profile);
                                            });
                                      },
                                    ),
                                  ],
                                ),

                                PTCustomTextField(
                                  name: 'firstname',
                                  decoration: InputDecoration(
                                    labelText:
                                        "${LocaleKeys.kFirstName.tr()} *",
                                  ),
                                  initialValue: state.userProfile?.firstname,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: LocaleKeys.kRequiredField.tr(),
                                    )
                                  ]),
                                ),
                                PTCustomTextField(
                                  name: 'lastname',
                                  initialValue: state.userProfile?.lastname,
                                  decoration: InputDecoration(
                                      labelText:
                                          "${LocaleKeys.kLastName.tr()} *"),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                CustomPhoneTextfield(
                                  label: "${LocaleKeys.kPhone.tr()} *",
                                  controller: cubit.phoneController,
                                  initialCountryCode: state.phoneCountry,
                                  initialValue: state.phoneNumber,
                                  hintText: LocaleKeys.kPhone.tr(),
                                  onChanged: (value) {
                                    cubit.onChangedPhoneCountry(
                                        countryCode: value.countryCode);
                                  },
                                  validator: (phone) {
                                    if (phone?.number == "") {
                                      return LocaleKeys.kRequiredField.tr();
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                PTCustomTextField(
                                  decoration: InputDecoration(
                                    labelText: LocaleKeys.kEmail.tr(),
                                  ),
                                  name: 'email',
                                  initialValue: state.userProfile?.email,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                PTDropdownField<Dropdowns>(
                                  name: 'gender',
                                  initialValue: Utils.getIntialDropdownValue(
                                      list: cubit.listGender,
                                      value: state.userProfile?.gender),
                                  decoration: InputDecoration(
                                      labelText:
                                          "${LocaleKeys.kGender.tr()} *"),
                                  source: cubit.listGender,
                                  valueTransformer: (Dropdowns? value) =>
                                      value?.value,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                PTDatePickerField(
                                  initialValue: state.userProfile?.dob,
                                  name: 'dob',
                                  inputType: InputType.date,
                                  decoration: InputDecoration(
                                    labelText: "${LocaleKeys.kDOB.tr()} *",
                                    suffixIcon: const Icon(Icons.date_range),
                                  ),
                                  valueTransformer: (value) =>
                                      value?.toIso8601String(),
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                PTCustomTextField(
                                  decoration: InputDecoration(
                                    labelText:
                                        "${LocaleKeys.kPassportNo.tr()} *",
                                  ),
                                  name: 'passport',
                                  initialValue: state.userProfile?.passport,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),

                                // Container(
                                //   decoration: const BoxDecoration(
                                //       border: Border(
                                //     bottom: BorderSide(
                                //         width: 1.5, color: Colors.grey),
                                //   )),
                                //   child: CountryListPick(
                                //     appBar: AppBar(
                                //       title: Text(LocaleKeys.kFromCountry.tr()),
                                //     ),
                                //     initialSelection:
                                //         cubit.currentUser?.countrycode,
                                //     pickerBuilder: (context, countryCode) {
                                //       return Container(
                                //         padding: const EdgeInsets.all(0),
                                //         margin: const EdgeInsets.all(0),
                                //         child: Row(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: <Widget>[
                                //             Image.asset(
                                //               countryCode!.flagUri!,
                                //               package: 'country_list_pick',
                                //               width: 32.0,
                                //             ),
                                //             Expanded(
                                //               child: Padding(
                                //                 padding: const EdgeInsets.only(
                                //                     left: 8.0),
                                //                 child: Text(countryCode
                                //                     .toCountryStringOnly()),
                                //               ),
                                //             ),
                                //             const Icon(
                                //                 Icons.keyboard_arrow_down)
                                //           ],
                                //         ),
                                //       );
                                //     },
                                //     theme: CountryTheme(
                                //         searchText: 'Serach',
                                //         isShowFlag: true,
                                //         isShowCode: false,
                                //         isDownIcon: true,
                                //         showEnglishName: true,
                                //         labelColor: AppColors.primaryColor,
                                //         alphabetTextColor: Colors.black),
                                //     onChanged: (value) {
                                //       // print(value?.name);
                                //     },
                                //   ),
                                // ),

                                const SizedBox(height: 10),
                                PTCustomTextField(
                                  decoration: InputDecoration(
                                    labelText: "${LocaleKeys.kCity.tr()} *",
                                  ),
                                  name: 'city',
                                  initialValue: state.userProfile?.city,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: LocaleKeys.kRequiredField.tr(),
                                    )
                                  ]),
                                ),
                                const SizedBox(height: 10),
                                PTCustomTextField(
                                  decoration: InputDecoration(
                                    labelText: "${LocaleKeys.kAddress.tr()} *",
                                  ),
                                  name: 'address',
                                  initialValue: state.userProfile?.address,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                      errorText: LocaleKeys.kRequiredField.tr(),
                                    )
                                  ]),
                                ),
                                PTDropdownField<Dropdowns>(
                                  name: 'purposeofvisit',
                                  initialValue: Utils.getIntialDropdownValue(
                                      list: state.listPurposes,
                                      value: state.userProfile?.purposeofvisit),
                                  source: state.listPurposes,
                                  decoration: InputDecoration(
                                    labelText:
                                        "${LocaleKeys.kPurposeOfVisit.tr()} *",
                                  ),
                                  valueTransformer: (Dropdowns? value) =>
                                      value?.value,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                PTDropdownField(
                                  name: 'province_id',
                                  initialValue: Utils.getIntialDropdownValue(
                                      list: state.listProvince,
                                      value: state.userProfile?.province_id),
                                  source: state.listProvince,
                                  decoration: InputDecoration(
                                    labelText: "${LocaleKeys.kProvince.tr()} *",
                                  ),
                                  valueTransformer: (Dropdowns? value) =>
                                      value?.value,
                                  validator: FormBuilderValidators.compose([
                                    FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr())
                                  ]),
                                ),
                                if (state.userProfile?.purposeofvisit
                                            ?.toLowerCase() !=
                                        "tour" &&
                                    state.userProfile?.purposeofvisit !=
                                        null) ...[
                                  PTCustomTextField(
                                    decoration: InputDecoration(
                                      labelText:
                                          "${LocaleKeys.kWorkPlace.tr()} *",
                                    ),
                                    name: 'workplace',
                                    validator: FormBuilderValidators.compose([
                                      FormBuilderValidators.required(
                                        errorText:
                                            LocaleKeys.kRequiredField.tr(),
                                      )
                                    ]),
                                  ),
                                ],

                                const SizedBox(height: 30),

                                // /// [Upload documents]
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, left: 5),
                                  width: double.infinity,
                                  color:
                                      const Color.fromARGB(255, 232, 230, 230),
                                  child: Text(
                                      "${LocaleKeys.kUploadDocument.tr()} *",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                UploadDocsWidget(
                                  isRequired: true,
                                  label: LocaleKeys.kPassportNo.tr(),
                                  description:
                                      LocaleKeys.kUploadyourpassport.tr(),
                                  url: state.passportPhoto,
                                  onTap: () {
                                    AppNavigator.showModalPopupPhoto(
                                        context: context,
                                        onCamera: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.camera,
                                              type: FileType.passport);
                                        },
                                        onGallery: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.gallery,
                                              type: FileType.passport);
                                        });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                UploadDocsWidget(
                                  label: LocaleKeys.kVaccine.tr(),
                                  description: LocaleKeys.kUploadyourvisa.tr(),
                                  url: state.vaccinePhoto,
                                  onTap: () {
                                    AppNavigator.showModalPopupPhoto(
                                        context: context,
                                        onCamera: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.camera,
                                              type: FileType.vaccine);
                                        },
                                        onGallery: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.gallery,
                                              type: FileType.vaccine);
                                        });
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),

                                UploadDocsWidget(
                                  label: LocaleKeys.kRTPCR.tr(),
                                  description: LocaleKeys.kDocumentphoto.tr(),
                                  url: state.RTPCRPhoto,
                                  onTap: () {
                                    AppNavigator.showModalPopupPhoto(
                                        context: context,
                                        onCamera: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.camera,
                                              type: FileType.rtpcr);
                                        },
                                        onGallery: (context) {
                                          AppNavigator.goBack();
                                          cubit.getImage(
                                              source: ImageSource.gallery,
                                              type: FileType.rtpcr);
                                        });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
