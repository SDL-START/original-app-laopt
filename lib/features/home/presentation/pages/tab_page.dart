import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/app_images.dart';

import '../../../../core/DI/service_locator.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/not_found.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../certification/presentration/cubit/certificate_cubit.dart';
import '../../../maps/presentation/cubit/map_cubit.dart';
import '../../../maps/presentation/pages/map_page.dart';
import '../../../settings/presentation/cubit/settings_cubit.dart';
import '../../../settings/presentation/pagse/setting_page.dart';
import '../../../support/presentation/cubit/support_cubit/support_cubit.dart';
import '../../../support/presentation/pages/list_tickets_page.dart';
import '../cubit/home_cubit/home_cubit.dart';
import '../cubit/tabs_cubit/tab_cubit.dart';
import 'home_page.dart';

class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TabCubit>();
    return BlocBuilder<TabCubit, TabState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: true,
              showUnselectedLabels: true,
              currentIndex: state.currentIndex,
              onTap: (index) {
                cubit.onChangedTab(index);
              },
              items: [
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.home_active,
                    width: 30,
                    height: 30,
                  ),
                  label: LocaleKeys.kHome.tr(),
                  backgroundColor: AppColors.primaryColor,
                  icon: Image.asset(
                    AppImages.home,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: LocaleKeys.kHome.tr(),
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.map_active,
                    width: 30,
                    height: 30,
                  ),
                  label: LocaleKeys.kMap.tr(),
                  backgroundColor: AppColors.primaryColor,
                  icon: Image.asset(
                    AppImages.map,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: LocaleKeys.kMap.tr(),
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.chat_active,
                    width: 30,
                    height: 30,
                  ),
                  label: LocaleKeys.kChat.tr(),
                  backgroundColor: AppColors.primaryColor,
                  icon: Image.asset(
                    AppImages.chat,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: LocaleKeys.kChat.tr(),
                ),
                BottomNavigationBarItem(
                  activeIcon: Image.asset(
                    AppImages.settings_active,
                    width: 30,
                    height: 30,
                  ),
                  label: LocaleKeys.kSettings.tr(),
                  backgroundColor: AppColors.primaryColor,
                  icon: Image.asset(
                    AppImages.settings,
                    width: 30,
                    height: 30,
                  ),
                  tooltip: LocaleKeys.kSettings.tr(),
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                switch (state.currentIndex) {
                  case 0:
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<HomeCubit>(
                            create: (context) => getIt<HomeCubit>()..initial()),
                        BlocProvider<CertificateCubit>(
                          create: (context) => getIt<CertificateCubit>(),
                        )
                      ],
                      child: HomePage(),
                    );
                  case 1:
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<MapCubit>(
                          create: (context) => getIt<MapCubit>()
                            ..getCurrentLocation()
                            ..getHospital(),
                        ),
                      ],
                      child: const MapPage(),
                    );
                  case 2:
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<SupportCubit>(
                          create: (context) =>
                              getIt<SupportCubit>()..getTicket(),
                        )
                      ],
                      child: const ListTicketPage(),
                    );
                  case 3:
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider<SettingsCubit>(
                          create: (context) =>
                              getIt<SettingsCubit>()..getLanguage(),
                        ),
                      ],
                      child: const SettingsPage(),
                    );
                  default:
                    return const NotFound();
                }
              },
            ),
          ),
        );
      },
    );
  }
}
