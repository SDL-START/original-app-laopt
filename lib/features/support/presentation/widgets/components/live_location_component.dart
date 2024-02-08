import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/app_lotties.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:lottie/lottie.dart';

import '../../../../../core/models/sos_message.dart';

class LiveLocationComponent extends StatelessWidget {
  final SOSMessage? message;
  const LiveLocationComponent({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        width: MediaQuery.of(context).size.width / 2,
        height: 100,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Lottie.asset(AppLotties.liveLocation, width: 50),
                  const Text("Live Location"),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                AppNavigator.navigateTo(
                  AppRoute.liveLocationRoute,
                  params: message?.messageId,
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: 30,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(8)),
                child: Center(
                  child: Text(
                    "View Location",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
