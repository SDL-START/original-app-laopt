import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/entities/webview_params.dart';
import '../../../../core/utils/app_navigator.dart';
import '../../../../core/utils/router.dart';
import '../../../../core/utils/utils.dart';
import '../../../../generated/assets.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../certification/presentration/cubit/certificate_cubit.dart';
import '../cubit/home_cubit/home_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state.status == DataStatus.failure) {
          Fluttertoast.showToast(
            msg: state.error ?? "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            timeInSecForIosWeb: 1,
          );
        } else if (state.status == DataStatus.success) {
          if (state.message != null) {
            Fluttertoast.showToast(
              msg: state.message ?? '',
              toastLength: Toast.LENGTH_SHORT,
              timeInSecForIosWeb: 1,
            );
          }
        }
      },
      buildWhen: (previous, current) => previous.listMenu != current.listMenu,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(LocaleKeys.kHome.tr()),
          ),
          body: Builder(builder: (context) {
            if (state.status == DataStatus.loading) {
              return const LoadingWidget();
            }
            return Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.imagesBg), fit: BoxFit.cover),
              ),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    pinned: false,
                    snap: false,
                    floating: false,
                    expandedHeight: 200,
                    flexibleSpace: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      ),
                      items: state.listSlideImage?.map((item) {
                            return Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: CachedNetworkImage(
                                imageUrl: item.image ?? '',
                                fit: BoxFit.cover,
                                height: 150,
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            primary: false,
                            itemCount: state.listMenu?.length,
                            padding: const EdgeInsets.only(bottom: 80),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1,
                            ),
                            itemBuilder: (context, index) {
                              final item = state.listMenu?[index];
                              return InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey.shade300, width: 1),
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white.withOpacity(0.6),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl: item?.icon ?? '',
                                        height: 70,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        Utils.getTranslate(context, item?.name),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  if (item?.iswebview == 1) {
                                    AppNavigator.navigateTo(
                                        AppRoute.myWebviewRoute,
                                        params: WebviewParams(
                                            name: item?.name, url: item?.url));
                                  } else {
                                    AppNavigator.navigateTo(item?.url ?? '');
                                  }
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
          floatingActionButton: (cubit.state.currentUser?.role == "STAFF")
              ? FloatingActionButton(
                  onPressed: () async {
                    await context.read<CertificateCubit>().onScan();
                  },
                  child: const Icon(Icons.qr_code_scanner_outlined),
                )
              : FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: (state.status != DataStatus.requesting)
                      ? () async {
                          await cubit.requestSOS();
                        }
                      : null,
                  child: (state.status == DataStatus.requesting)
                      ? const CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        )
                      : const Text('SOS'),
                ),
        );
      },
    );
  }
}
