import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/cubit/buy_insurance_cubit.dart';
import 'package:insuranceapp/features/buy_insurance/presentation/pages/policy_schedule_page.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/constant.dart';
import '../../../../core/widgets/upload_docs_widget.dart';

class UploadDocumentPage extends StatelessWidget {
  const UploadDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<BuyInsuranceCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kUploadDocument.tr()),
      ),
      body: BlocBuilder<BuyInsuranceCubit, BuyInsuranceState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // const Text("Please upload you documnet photo"),
                  Text(LocaleKeys.kDocumentphoto.tr()),

                  // Text(
                  //     "If you do not want to see this page please update your profile"),
                  const SizedBox(height: 20),
                  UploadDocsWidget(
                    isRequired: true,
                    label: LocaleKeys.kPassportNo.tr(),
                    // description: "Upload your passport photo",
                    description: LocaleKeys.kUploadyourpassport.tr(),
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
                    description: LocaleKeys.kDocuments.tr(),
                    url: state.rtpcrPhoto,
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
          );
        },
      ),
      floatingActionButton: BlocBuilder<BuyInsuranceCubit, BuyInsuranceState>(
        builder: (context, state) {
          return FloatingActionButton.extended(
              onPressed: () {
                if (state.passportPhoto != null && state.passportPhoto != "") {
                  cubit.onSvaeDocument();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          BlocProvider<BuyInsuranceCubit>.value(
                        value: cubit,
                        child: const PolicyShedulePage(),
                      ),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "Please upload your passport photo");
                }
              },
              label: Row(
                children: [
                  const SizedBox(width: 10),
                  Text(LocaleKeys.kSave.tr()),
                ],
              ));
        },
      ),
    );
  }
}
