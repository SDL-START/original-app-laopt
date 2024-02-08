import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/utils/utils.dart';
import '../cubit/claim_cubit.dart';

class UploadClaimDocumentPage extends StatelessWidget {
  const UploadClaimDocumentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ClaimCubit>();
    return BlocBuilder<ClaimCubit, ClaimState>(
      builder: (context, state) {
        if(state.status == DataStatus.loading){
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Uplaod document"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.add_a_photo_outlined),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: 150,
                            width: double.infinity,
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      cubit.getImage(
                                          source: ImageSource.camera);
                                    },
                                    icon: const Icon(Icons.camera_alt),
                                    label: Text(LocaleKeys.kCamera.tr()),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      cubit.getImage(
                                          source: ImageSource.gallery);
                                    },
                                    icon: const Icon(Icons.photo_album),
                                    label: Text(LocaleKeys.kGallery.tr()),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  const Text("Add documents photo for claim"),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: state.listDocument.map((data) {
                          return CachedNetworkImage(
                            imageUrl: Utils.onGenerateImageUrl(url: data),
                            height: 300,
                            errorWidget: (context, url, error) {
                              return const Icon(
                                  Icons.photo_camera_back_outlined);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              if (state.listDocument.isNotEmpty) {
                await cubit.onRequestClaim();
              } else {
                Fluttertoast.showToast(msg: "Please add a photo document for claim");
              }
            },
            icon: const Icon(Icons.arrow_forward),
            label: Text(LocaleKeys.kNext.tr()),
          ),
        );
      },
    );
  }
}
