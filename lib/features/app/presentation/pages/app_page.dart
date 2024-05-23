import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/features/app/presentation/cubit/app_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../../generated/assets.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
        buildWhen: (previous, current) =>
            previous.versionStatus != current.versionStatus,
        listener: (context, state) {
          if (state.versionStatus?.canUpdate == true) {
            AppNavigator.showOptionDialog(
                title: const Text("Update Available"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("You can update new version"),
                    Text("${state.versionStatus?.storeVersion}"),
                  ],
                ),
                onCancel: () {
                  if (state.isAuth) {
                    AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
                  } else {
                    AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
                  }
                },
                action: () async {
                  if (await canLaunchUrl(
                      Uri.parse(state.versionStatus?.appStoreLink ?? ''))) {
                    AppNavigator.goBack();
                    await launchUrl(
                      Uri.parse(state.versionStatus?.appStoreLink ?? ''),
                    );
                  }
                });
          } else {
            if (state.isAuth) {
              AppNavigator.pushAndRemoveUntil(AppRoute.homeRoute);
            } else {
              AppNavigator.pushAndRemoveUntil(AppRoute.loginRoute);
            }
          }
        },
        builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage(Assets.imagesBg),
                  fit: BoxFit.fill,
                  opacity: 0.9),
            ),
          );
        },
      ),
    );
  }
}
