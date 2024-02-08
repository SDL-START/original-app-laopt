import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/support/presentation/cubit/location_cubit/location_cubit.dart';

class LiveLocationpage extends StatefulWidget {
  const LiveLocationpage({super.key});

  @override
  State<LiveLocationpage> createState() => _LiveLocationpageState();
}

class _LiveLocationpageState extends State<LiveLocationpage> {
   BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  @override
  void initState() {
    addCustomIcon();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(10, 10)), "assets/images/user_location.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Live Location"),
      ),
      body: BlocBuilder<LocationCubit, LocationState>(
        buildWhen: (previous, current) =>
            previous.locationLog != current.locationLog,
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(state.currentLocation?.latitude ?? 0,
                  state.currentLocation?.longitude ?? 0),
              zoom: 14,
            ),
            myLocationButtonEnabled: false,
            cameraTargetBounds: CameraTargetBounds.unbounded,
            minMaxZoomPreference: MinMaxZoomPreference.unbounded,
            markers: {
              Marker(
                  markerId: MarkerId('${state.currentLocation.hashCode}'),
                  position: LatLng(
                    state.currentLocation?.latitude ?? 0,
                    state.currentLocation?.longitude ?? 0,
                  ),
                  icon: markerIcon,
                  infoWindow: const InfoWindow(title: "You")),
              Marker(
                markerId: MarkerId('${state.locationLog?.id}'),
                position: LatLng(
                    state.locationLog?.lat ?? 0, state.locationLog?.lng ?? 0),
              )
            },
          );
        },
      ),
    );
  }
}
