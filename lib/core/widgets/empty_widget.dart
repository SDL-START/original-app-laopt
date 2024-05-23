import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:insuranceapp/generated/assets.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class EmptyWidget extends StatelessWidget {
  final String? message;
  const EmptyWidget({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.imagesEmptyBox, height: 80),
            Text(
              message ?? LocaleKeys.KEmpty.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
