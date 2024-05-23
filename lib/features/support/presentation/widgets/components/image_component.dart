import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/models/sos_message.dart';

class ImageComponent extends StatelessWidget {
  final SOSMessage? message;
  final Function()? onTap;
  const ImageComponent({
    super.key,
    this.message,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: '${message?.image}',
        imageBuilder: (context, imageProvider) {
          return Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(width: 2, color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
            ),
          );
        },
      ),
    );
  }
}
