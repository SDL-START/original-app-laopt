import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileWidget extends StatelessWidget {
  final String? url;
  final GestureTapCallback? onTap;
  const ProfileWidget({super.key, this.url, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: "${APIPath.publicUrl}/$url",
        height: 125,
        width: 125,
        imageBuilder: (context, imageProvider) {
          return Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor),
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          );
        },
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            height: 125,
            width: 125,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primaryColor),
            ),
            child:const CircularProgressIndicator(),
          );
        },
        errorWidget: (context, url, error) => Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.primaryColor),
          ),
          child: const Center(
            child: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
