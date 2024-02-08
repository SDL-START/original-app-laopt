import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/failure_widget.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/assets.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/widgets/pt_custom_button.dart';
import '../cubit/login_cubit.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(Assets.imagesBg),
            fit: BoxFit.fill,
            opacity: 0.9),
      ),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          } else if (state.status == DataStatus.failure) {
            return FailureWidget(message: state.error);
          }
          return Scaffold(
            backgroundColor: Colors.transparent,
            floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.language_outlined),
              onPressed: () async {
                await AppNavigator.navigateToWithData(AppRoute.langRoute);
              },
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 24, top: 32, right: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(Assets.imagesLogoInsurance, height: 200),
                              const SizedBox(height: 15),
                              Text(
                                LocaleKeys.kCompanyName.tr(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              PTCustomButton(
                                label: LocaleKeys.kLoginWithEmail.tr(),
                                onTap: () {
                                  AppNavigator.navigateTo(
                                      AppRoute.loginDetailRoute,
                                      params: false);
                                },
                              ),
                              const SizedBox(height: 15),
                              PTCustomButton(
                                label: LocaleKeys.kLoginWithPhone.tr(),
                                onTap: () {
                                  AppNavigator.navigateTo(
                                      AppRoute.loginDetailRoute,
                                      params: true);
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.kDontHaveAnAccount.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            color: Colors.white, fontSize: 16),
                                  ),
                                  const SizedBox(width: 2),
                                  TextButton(
                                    onPressed: () {
                                      AppNavigator.navigateTo(
                                          AppRoute.registerRoute);
                                    },
                                    child: Text(
                                      LocaleKeys.kRegister.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, bottom: 15),
                      child: Text(
                        LocaleKeys.kVersion
                            .tr(args: ["${state.packageInfo?.version} - ${state.packageInfo?.buildNumber}"]),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
