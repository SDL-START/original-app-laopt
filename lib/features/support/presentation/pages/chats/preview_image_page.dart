import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/extensions/date_time_extension.dart';

import '../../../../../core/params/preview_img_params.dart';

class PreviewImage extends StatelessWidget {
  final PreviewImageParams? params;
  const PreviewImage({super.key, this.params});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 1,
        title: Text(
          params?.createdAt.formatDatetimeShort() ?? '',
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
                fontSize: 14,
                color: Colors.black,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: CachedNetworkImage(
            imageUrl: params?.imageUrl ?? '',
          ),
        ),
      ),
    );
  }
}
