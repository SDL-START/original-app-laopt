import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/core/utils/router.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/maps/presentation/cubit/map_cubit.dart';
import 'package:insuranceapp/features/maps/presentation/cubit/map_state.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../core/models/hospital.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapCubit>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text( 
          LocaleKeys.kHospitalAndService.tr(),
        ),
      ),
      body: BlocConsumer<MapCubit, MapState>(
        listener: (context, state) {},
        builder: (context, state) {
          return BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              if (state.status == MapStatus.LOADING) {
                return const LoadingWidget();
              }
              return SlidingUpPanel(
                panel: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 195, 193, 193),
                              borderRadius: BorderRadius.circular(2)),
                          width: 40,
                          height: 8,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      LocaleKeys.kNearBy.tr(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: cubit.listDistamce.map((hospital) {
                          return Column(
                            children: [
                              ListTile(
                                leading: const Icon(
                                  Icons.pin_drop,
                                  color: Colors.red,
                                ),
                                title: Text(hospital.name ?? ''),
                                subtitle: Row(
                                  children: [
                                    Text('${hospital.distance} Km'),
                                    const SizedBox(width: 10),
                                    (hospital.type == '1')
                                        ? Text(LocaleKeys.kHospital.tr())
                                        : Text(LocaleKeys.kServiceUnits.tr()),
                                  ],
                                ),
                                onTap: () {
                                  Hospital? hos = cubit.listHospital.where((el) => el.id == hospital.id).isEmpty?null:cubit.listHospital.where((el) => el.id == hospital.id).first;
                                  AppNavigator.navigateTo(
                                      AppRoute.hospitalDetailRoute,
                                      params: hos);
                                },
                              ),
                              const Divider(),
                            ],
                          );
                        }).toList()),
                      ),
                    )
                  ],
                ),
                color: Colors.white.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
                minHeight: 80,
                body: Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(cubit.currentLocationData?.latitude ?? 0,
                            cubit.currentLocationData?.longitude ?? 0),
                        zoom: 15,
                      ),
                      trafficEnabled: true,
                      compassEnabled: true,
                      mapToolbarEnabled: true,
                      myLocationEnabled: false,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: false,
                      markers: cubit.markers.values.toSet(),
                      onMapCreated: (GoogleMapController controller) {
                        cubit.controller.complete(controller);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.white),
                            child: const Center(
                              child: Icon(Icons.my_location),
                            ),
                          ),
                          onTap: () {
                            cubit.myLocation(
                                lat: cubit.currentLocationData?.latitude ?? 0,
                                lng: cubit.currentLocationData?.longitude ?? 0);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
