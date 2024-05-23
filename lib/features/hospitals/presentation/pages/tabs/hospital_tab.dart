import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/models/hospital.dart';

import '../../../../../../core/utils/app_navigator.dart';
import '../../../../../../core/utils/router.dart';

class HospitalTab extends StatelessWidget {
  final List<Hospital> listHospital;
  const HospitalTab({super.key, required this.listHospital});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: listHospital
            .map((hospital) => Column(
                  children: [
                    ListTile(
                      minVerticalPadding: 15,
                      leading:
                          hospital.images == null || hospital.images!.isEmpty
                              ? const Icon(Icons.error)
                              : CachedNetworkImage(
                                  width: 40,
                                  height: 40,
                                  imageUrl: hospital.images?.first ?? '',
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                      title: Text(hospital.name ?? ''),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(hospital.tel ?? ''),
                          Text(hospital.address ?? ''),
                        ],
                      ),
                      onTap: () {
                        AppNavigator.navigateTo(AppRoute.hospitalDetailRoute,
                            params: hospital);
                      },
                    ),
                    const Divider(),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
