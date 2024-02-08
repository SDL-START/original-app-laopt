import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constants/api_path.dart';

class UploadDocsWidget extends StatelessWidget {
  final String? label;
  final String? description;
  final bool isRequired;
  final String? url;
  final GestureTapCallback? onTap;

  const UploadDocsWidget(
      {super.key,
      this.label,
      this.description,
      this.isRequired = false,
      this.url,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isRequired ? "$label *" : label ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(description ?? ''),
        const SizedBox(height: 8),
        Card(
          child: InkWell(
            onTap: onTap,
            child: SizedBox(
              width: double.infinity,
              height: 150,
              child: url == null
                  ? const Center(
                      child: Icon(Icons.drive_folder_upload_outlined),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: "${APIPath.publicUrl}/$url",
                        fit: BoxFit.contain,
                        errorWidget: (context, url, error) {
                          return const Center(
                            child: Icon(Icons.error),
                          );
                        },
                        progressIndicatorBuilder: (context, url, progress) {
                          return const Center(
                            child: SizedBox(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
