import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/utils/app_navigator.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../cubit/sos_cubit.dart';
import '../widgets/description_input_field.dart';
import '../widgets/map_bar_widget.dart';

class SOSDetailStaffPage extends StatelessWidget {
  const SOSDetailStaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SosCubit>();
    return BlocBuilder<SosCubit, SosState>(
      buildWhen: (previous, current) => previous.ticket != current.ticket,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("STAFF - SOS"),
            actions: [
              if (state.ticket?.status == TicketStatus.pending) ...[
                TextButton(
                  onPressed: () {
                    AppNavigator.showOptionDialog(
                        title: Text(LocaleKeys.kWarnning.tr()),
                        content: Text(LocaleKeys.kCancelTicket.tr()),
                        action: () async {
                          AppNavigator.goBack();
                          await cubit.ticketAction(
                              ticketActions: TicketActions.CANCELED);
                        });
                  },
                  child: Text(
                    LocaleKeys.kCancel.tr(),
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            ],
          ),
          body: Builder(builder: (context) {
            if (state.status == DataStatus.loading) {
              return const LoadingWidget();
            }
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: false,
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  initialCameraPosition: CameraPosition(
                    target:
                        LatLng(state.ticket?.lat ?? 0, state.ticket?.lng ?? 0),
                    zoom: 18,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId("${state.ticket?.ticketId}"),
                      position: LatLng(
                        state.ticket?.lat ?? 0,
                        state.ticket?.lng ?? 0,
                      ),
                      infoWindow: InfoWindow(
                        title:
                            "${state.ticket?.user?.firstname} ${state.ticket?.user?.lastname}",
                        snippet: state.ticket?.description,
                      ),
                    ),
                    Marker(
                      markerId:
                          MarkerId(state.locationData.hashCode.toString()),
                      position: LatLng(
                        state.locationData?.latitude ?? 0,
                        state.locationData?.longitude ?? 0,
                      ),
                      infoWindow: const InfoWindow(
                        title: 'You',
                      ),
                    ),
                  },
                  onMapCreated: (controller) {
                    cubit.mapController.complete(controller);
                  },
                ),
                Column(
                  children: [
                    MapBarWidget(
                      ticket: state.ticket,
                      onTap: () async {
                        await cubit.moveLocation(
                          lat: state.ticket?.lat ?? 0,
                          lng: state.ticket?.lng ?? 0,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Container(
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade600,
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                )
                              ]),
                          child: IconButton(
                            onPressed: () async {
                              await cubit.moveLocation(
                                  lat: state.locationData?.latitude ?? 0,
                                  lng: state.locationData?.longitude ?? 0);
                            },
                            icon: const Icon(
                              Icons.my_location_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          }),
          floatingActionButton: (state.ticket?.status == TicketStatus.pending)
              ? FloatingActionButton.extended(
                  icon: const Icon(Icons.check),
                  label: Text(LocaleKeys.kAccept.tr()),
                  onPressed: () {
                    AppNavigator.showOptionDialog(
                      title: Text(LocaleKeys.kConfirmation.tr().toUpperCase()),
                      content: DescriptionInputField(
                        controller: cubit.descriptionController,
                      ),
                      action: () async {
                        AppNavigator.goBack();
                        await cubit.ticketAction(
                          ticketActions: TicketActions.INPROGRESS,
                        );
                      },
                    );
                  },
                )
              : FloatingActionButton.extended(
                  icon: const Icon(Icons.check),
                  label: Text(LocaleKeys.kComplete.tr().toUpperCase()),
                  onPressed: () {
                    AppNavigator.showOptionDialog(
                      title: Text(LocaleKeys.kConfirmation.tr().toUpperCase()),
                      content: DescriptionInputField(
                        controller: cubit.descriptionController,
                      ),
                      action: () async {
                        AppNavigator.goBack();
                        await cubit.ticketAction(
                          ticketActions: TicketActions.COMPLETED,
                        );
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}
