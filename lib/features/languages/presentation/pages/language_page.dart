import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/entities/localization.dart';
import '../../../../generated/assets.dart';
import '../cubit/language_cubit.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LanguageCubit>();
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        if (state.status == DataStatus.loading) {
          return const LoadingWidget();
        }
        final List<Localization> listLocale = [
          Localization(
              code: "en", name: LocaleKeys.kEnLable.tr(), flag: Assets.flagsUs),
          Localization(
              code: "lo", name: LocaleKeys.kLaoLable.tr(), flag: Assets.flagsLa),
          Localization(
              code: "zh", name: LocaleKeys.kChinese.tr(), flag: Assets.flagsCn),
              Localization(
              code: "vi", name: LocaleKeys.kVietnamese.tr(), flag: Assets.flagsVn),
        ];
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kChangeLanguage.tr()),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () {
                AppNavigator.goBackWithData(data: state.langCode);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: Column(
                children: List.generate(
                  listLocale.length,
                  (index) {
                    final Localization localize = listLocale[index];
                    return Column(
                      children: [
                        RadioListTile<String?>(
                          value: localize.code,
                          groupValue: state.langCode,
                          title: Text(localize.name),
                          secondary: Image(
                            image: AssetImage(localize.flag),
                            width: 30,
                          ),
                          onChanged: (String? value)async {
                            await context.setLocale(Locale(value??"en"));
                            await cubit.setLanguage(code: value??'en');
                          },
                        ),
                        const Divider()
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
