import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
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
    final List<String> imageUrl = [
      "https://laostravel.com/images/2021/02/plain-of-jars00.jpg",
      "https://laostravel.com/images/2019/06/Pha-Ngeun-Cliff-2.jpg",
      // "https://laostravel.com/images/2019/06/Zipline-tours-in-Vang-VIeng.jpg",
      // "https://laostravel.com/images/2019/06/Laos-Luang-Prabang-Wat-Visoun-1.jpg",
    ];
    List<Widget> images = imageUrl
        .map((url) => Image.network(
              url,
              fit: BoxFit.cover,
            ))
        .toList();
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
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            // title: Text(LocaleKeys.kHome.tr()),
            title: Text(
              'LAOPT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Builder(builder: (context) {
            if (state.status == DataStatus.loading) {
              return const LoadingWidget();
            }
            return Container(
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //       image: AssetImage(Assets.imagesBg), fit: BoxFit.cover),
              // ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
                  // top: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      ),
                      items: state.listSlideImage?.map((item) {
                            return Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 15),
                              child: CachedNetworkImage(
                                imageUrl: item.image ?? '',
                                fit: BoxFit.cover,
                                height: 160,
                              ),
                            );
                          }).toList() ??
                          [],
                    ),
                    Text(
                      LocaleKeys.kService.tr(),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      primary: false,
                      itemCount: state.listMenu?.length,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        crossAxisCount: 3,
                        // childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        final item = state.listMenu?[index];
                        print('Hello soumdee11111 {$item}');
                        print("hello {$item}");
                        return InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              color: Colors.white.withOpacity(
                                0.6,
                              ),
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
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            // print("hellow ");
                            if (item?.iswebview == 1) {
                              AppNavigator.navigateTo(
                                AppRoute.myWebviewRoute,
                                params: WebviewParams(
                                  name: item?.name,
                                  //url link travel and policy
                                  url: item?.url,
                                ),
                              );
                            } else {
                              AppNavigator.navigateTo(
                                item?.url ?? '',
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            );
          }),
          floatingActionButton: (cubit.state.currentUser?.role == "STAFF")
              ? FloatingActionButton(
                  onPressed: () async {
                    await context.read<CertificateCubit>().onScan();
                  },
                  child: Icon(
                    Icons.qr_code_scanner_outlined,
                  ),
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
                      : const Text(
                          'SOS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
        );
      },
    );
  }
}
