import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/entities/webview_params.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:insuranceapp/features/settings/presentation/widgets/setting_item.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/constants/api_path.dart';
import '../../../../core/utils/utils.dart';
import '../../../../generated/assets.dart';

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
        if(state.status==DataStatus.logout){
          Navigator.of(context).pushReplacementNamed(AppRoute.loginRoute);
        }
      },
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kSettings.tr()),
          ),
          body: Stack(
            children: [
              //Backgroud
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.imagesBg),
                    fit: BoxFit.cover,
                    // opacity: 0.8
                  ),
                ),
              ),

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
                          width: 40,
                          height: 40,
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
                      SettingsItem(
                        icon: Icons.view_list_outlined,
                        title: LocaleKeys.kPolicy.tr(),
                        onTap: () {
                          AppNavigator.navigateTo(AppRoute.myWebviewRoute,params: WebviewParams(
                            label: LocaleKeys.kPolicy.tr(),
                            url: '${APIPath.baseUrl}/policy-${Utils.convertCode(context: context)}.html?1=1'
                          ));
                        },
                      ),
                      const SizedBox(height: 15),
                      SettingsItem(
                        icon: Icons.exit_to_app,
                        title: LocaleKeys.kLogout.tr(),
                        onTap: () async{
                          await cubit.logOut();
                        },
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          LocaleKeys.kDeleteAccount.tr(),
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      )
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
