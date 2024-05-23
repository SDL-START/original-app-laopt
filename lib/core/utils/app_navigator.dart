import 'dart:io';

import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class AppNavigator {
  static GlobalKey<NavigatorState>? navigatorKey;
  // make this nullable by adding '?'
  static AppNavigator? _instance;

  AppNavigator._() {
    // initialization and stuff
    navigatorKey = GlobalKey<NavigatorState>();
  }

  factory AppNavigator() {
    _instance ??= AppNavigator._();
    // since you are sure you will return non-null value, add '!' operator
    return _instance!;
  }
  static void navigateTo(String routeName, {dynamic params}) {
    navigatorKey!.currentState?.pushNamed(routeName, arguments: params);
  }

  static void goBack() {
    navigatorKey!.currentState!.pop();
  }

  static void goBackUntil(String routeName) {
    navigatorKey!.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  static void pushAndRemoveUntil(String routeName, {dynamic params}) {
    navigatorKey!.currentState!.pushNamedAndRemoveUntil(
        routeName, (route) => false,
        arguments: params);
  }

  static void goBackWithData({dynamic data}) {
    navigatorKey!.currentState!.pop(data);
  }

  static navigateToWithData(String routeName, {dynamic params}) {
    return navigatorKey!.currentState?.pushNamed(routeName, arguments: params);
  }

  static openModal({required Widget body}) {
    if (Platform.isIOS) {
      showCupertinoModalBottomSheet(
        context: navigatorKey!.currentContext!,
        barrierColor: Colors.black,
        enableDrag: false,
        expand: true,
        builder: (context) {
          return body;
        },
      );
    } else {
      showMaterialModalBottomSheet(
        context: navigatorKey!.currentContext!,
        barrierColor: Colors.black,
        enableDrag: false,
        builder: (context) {
          return body;
        },
      );
    }
  }

  static void showModalBottomSheetImage({
    VoidCallback? onCamera,
    VoidCallback? onGallery,
  }) {
    showModalBottomSheet(
      context: navigatorKey!.currentContext!,
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
                  onPressed: onCamera,
                  icon: const Icon(Icons.camera_alt),
                  label: Text(LocaleKeys.kCamera.tr()),
                ),
              ),
              Expanded(
                flex: 1,
                child: TextButton.icon(
                  onPressed: onGallery,
                  icon: const Icon(Icons.photo_album),
                  label: Text(LocaleKeys.kGallery.tr()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static dynamic showModalPopupPhoto(
      {required BuildContext context,
      required Function(BuildContext) onCamera,
      required Function(BuildContext) onGallery}) {
    showAdaptiveActionSheet(
      androidBorderRadius: 0,
      context: context,
      actions: [
        BottomSheetAction(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.add_a_photo_outlined),
              const SizedBox(width: 10),
              Text(LocaleKeys.kCamera.tr(),
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          onPressed: onCamera,
        ),
        BottomSheetAction(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate_outlined),
              const SizedBox(width: 10),
              Text(LocaleKeys.kGallery.tr(),
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          onPressed: onGallery,
        ),
      ],
      cancelAction: CancelAction(title: Text(LocaleKeys.kCancel.tr())),
    );
  }

  static dynamic launchMap({double? lat, double? lng}) async {
    if (await MapLauncher.isMapAvailable(MapType.google) == true) {
      await MapLauncher.showMarker(
        mapType: MapType.google,
        coords: Coords(lat ?? 0, lng ?? 0),
        title: "",
        description: "",
      );
    } else {
      final String url = "https://www.google.com/maps/@$lat,$lng,16z";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        throw "Can not open maps";
      }
    }
  }

  static dynamic showOptionDialog(
      {Widget? title,
      Widget? content,
      Function()? action,
      Function()? onCancel}) {
    if (Platform.isAndroid) {
      showDialog(
          context: navigatorKey!.currentContext!,
          builder: (context) {
            return AlertDialog(
              title: title,
              content: content,
              actions: [
                TextButton(
                  onPressed: onCancel ??
                      () {
                        AppNavigator.goBack();
                      },
                  child: Text(
                    LocaleKeys.kCancel.tr(),
                  ),
                ),
                TextButton(
                  onPressed: action,
                  child: Text(
                    LocaleKeys.kOk.tr(),
                  ),
                )
              ],
            );
          });
    } else {
      showCupertinoDialog(
          context: navigatorKey!.currentContext!,
          builder: (context) {
            return CupertinoAlertDialog(
              title: title,
              content: content,
              actions: [
                TextButton(
                  onPressed: onCancel ??
                      () {
                        AppNavigator.goBack();
                      },
                  child: Text(
                    LocaleKeys.kCancel.tr(),
                  ),
                ),
                TextButton(
                  onPressed: action,
                  child: Text(
                    LocaleKeys.kOk.tr(),
                  ),
                )
              ],
            );
          });
    }
  }
}
