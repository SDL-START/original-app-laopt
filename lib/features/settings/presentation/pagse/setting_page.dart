import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/core/widgets/policy_en.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/features/settings/presentation/widgets/setting_item.dart';
import 'package:insuranceapp/features/travel/pages/dashoard_travel.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    return BlocConsumer<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (state.status == DataStatus.logout) {
          Navigator.of(context).pushReplacementNamed(AppRoute.loginRoute);
        }
      },
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            title: Text(LocaleKeys.kSettings.tr()),
          ),
          body: Stack(
            children: [
              //Backgroud
              // Container(
              //   // decoration: const BoxDecoration(color: Colors.grey
              //       // image: DecorationImage(
              //       //   image: AssetImage(Assets.imagesBg),
              //       //   fit: BoxFit.cover,
              //       //   // opacity: 0.8
              //       // ),
              //       // ),
              // ),

              //Body
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      SettingsItem(
                        icon: Icons.account_circle_outlined,
                        title: LocaleKeys.kProfile.tr(),
                        onTap: () {
                          AppNavigator.navigateTo(AppRoute.profileRoute);
                        },
                      ),
                      const SizedBox(height: 10),
                      // Language
                      SettingsItem(
                        icon: Icons.translate,
                        title: LocaleKeys.kLanguage.tr(),
                        trailing: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: AssetImage(cubit.onGenerateFlag(
                                  code: state.languageCode)),
                            ),
                          ),
                        ),
                        onTap: () async {
                          final data = await AppNavigator.navigateToWithData(
                              AppRoute.langRoute);
                          if (data != null) {
                            cubit.getLanguage();
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      SettingsItem(
                        icon: Icons.key_outlined,
                        title: LocaleKeys.kChangePassword.tr(),
                        onTap: () {
                          AppNavigator.navigateTo(AppRoute.changePasswordRoute);
                        },
                      ),
                      const SizedBox(height: 10),
                      // SettingsItem(
                      //   icon: Icons.policy_outlined,
                      //   title: LocaleKeys.kPolicy.tr(),
                      //   onTap: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         // builder: (context) => PolicyEn(),
                      //         builder: (context) => DashoardTravel(),
                      //       ),
                      //     );

                      //     // MaterialPageRoute(
                      //     //   builder: (context) => ProfilePage(),
                      //     // );
                      //     // AppNavigator.navigateTo(
                      //     //   AppRoute.myWebviewRoute,
                      //     //   params: WebviewParams(
                      //     //     label: LocaleKeys.kPolicy.tr(),
                      //     //     url:
                      //     //         '${APIPath.baseUrl}/policy-${Utils.convertCode(context: context)}.html?1=1',
                      //     //   ),
                      //     // );
                      //   },
                      // ),
                      const SizedBox(height: 15),
                      SettingsItem(
                        icon: Icons.exit_to_app,
                        title: LocaleKeys.kLogout.tr(),
                        onTap: () async {
                          await cubit.logOut();
                        },
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: Text(
                      //     LocaleKeys.kDeleteAccount.tr(),
                      //     style: const TextStyle(
                      //       color: Colors.red,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
