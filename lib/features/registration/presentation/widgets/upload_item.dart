import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/api_path.dart';

class UploadItem extends StatelessWidget {
  final String url;
  final String? title;
  final GestureTapCallback? onTap;
  const UploadItem({
    super.key,
    required this.url,
    this.title,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.only(left: 5, top: 8, bottom: 8),
        child: ListTile(
          contentPadding:
              const EdgeInsets.only(left: 8, right: 16, top: 8, bottom: 8),
          trailing: CachedNetworkImage(
            imageUrl: APIPath.publicUrl + url,
            width: 100,
            height: 100,
            errorWidget: (context, error, stackTrace) {
              return const Icon(Icons.add_photo_alternate_outlined);
            },
          ),
          title: Text(title ?? ''),
          onTap: onTap,
        ),
      ),
    );
  }
}
