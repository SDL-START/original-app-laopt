import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../core/models/sos_message.dart';
import '../../../../../core/utils/app_navigator.dart';

class MapComponent extends StatelessWidget {
  final SOSMessage? message;
  const MapComponent({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 2,
          height: 150,
          child: GoogleMap(
              onTap: (location) async {
                await AppNavigator.launchMap(
                    lat: location.latitude, lng: location.longitude);
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(message?.lat ?? 0, message?.lng ?? 0),
                  zoom: 16),
              myLocationButtonEnabled: false,
              zoomGesturesEnabled: false,
              rotateGesturesEnabled: false,
              scrollGesturesEnabled: false,
              zoomControlsEnabled: false,
              cameraTargetBounds: CameraTargetBounds.unbounded,
              minMaxZoomPreference: MinMaxZoomPreference.unbounded,
              markers: {
                Marker(
                  markerId: MarkerId('${message?.messageId}'),
                  position: LatLng(message?.lat ?? 0, message?.lng ?? 0),
                )
              }),
        ),
      ),
    );
  }
}
