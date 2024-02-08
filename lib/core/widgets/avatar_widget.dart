import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class AvatarWidget extends StatelessWidget {
  final String? url;
  final GestureTapCallback? onTap;
  const AvatarWidget({super.key, this.url, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: (url == null)
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage(Assets.imagesLogoInsurance))),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      image: DecorationImage(
                          image: NetworkImage(url ?? ''), fit: BoxFit.cover)),
                ),
              ),
      ),
    );
  }
}
