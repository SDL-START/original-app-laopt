import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../cubit/register_cubit.dart';
import '../cubit/register_state.dart';
import '../widgets/upload_item.dart';

class UploadDocuments extends StatelessWidget {
  const UploadDocuments({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(LocaleKeys.kUploadDocument.tr()),
      ),
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.status == RegisterStatus.UPLOADED) {
            Fluttertoast.showToast(msg: "Upload success");
          } else if (state.status == RegisterStatus.UPLOAD_FAILE) {
            Fluttertoast.showToast(msg: state.error ?? '');
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
                  UploadItem(
                    url: cubit.passport,
                    title: LocaleKeys.kPassportNo.tr(),
                    onTap: () {
                      AppNavigator.showModalBottomSheetImage(onCamera: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.camera,
                            type: FileType.passport);
                      }, onGallery: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.gallery,
                            type: FileType.passport);
                      });
                    },
                  ),
                  UploadItem(
                    url: cubit.vaccine,
                    title: LocaleKeys.kVaccine.tr(),
                    onTap: () {
                      AppNavigator.showModalBottomSheetImage(onCamera: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.camera, type: FileType.vaccine);
                      }, onGallery: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.gallery,
                            type: FileType.vaccine);
                      });
                    },
                  ),
                  UploadItem(
                    url: cubit.rtpcr,
                    title: LocaleKeys.kRTPCR.tr(),
                    onTap: () {
                      AppNavigator.showModalBottomSheetImage(onCamera: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.camera, type: FileType.rtpcr);
                      }, onGallery: () {
                        AppNavigator.goBack();
                        cubit.getImage(
                            source: ImageSource.gallery, type: FileType.rtpcr);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          AppNavigator.navigateTo(AppRoute.setPasswordRoute, params: cubit);
        },
        label: Text(
          LocaleKeys.kNext.tr(),
        ),
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
