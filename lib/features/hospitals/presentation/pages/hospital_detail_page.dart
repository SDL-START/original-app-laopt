import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/hospital.dart';
import 'package:insuranceapp/core/utils/utils.dart';
import 'package:insuranceapp/core/widgets/build_item.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;
  const HospitalDetailPage({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: (hospital.type == "1")
            ? Text(LocaleKeys.kHospitalName.tr(args: [hospital.name ?? '']))
            : Text(LocaleKeys.kServiceUnitsName.tr(args: [hospital.name ?? ''])),
        actions: [
          IconButton(
            onPressed: () {
              Utils.openUrl(
                  'https://www.google.com/maps/@${hospital.lat},${hospital.lng},16z');
            },
            icon: const Icon(
              Icons.directions_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            (hospital.images != null && hospital.images!.isNotEmpty)
                ? SizedBox(
                    height: 150,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enableInfiniteScroll: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.scale,
                      ),
                      items: hospital.images?.map((item) {
                        String imageUrl = item;
                        if (!item.startsWith('http')) {
                          imageUrl = APIPath.publicUrl + item;
                        }
                        return InkWell(
                          child: CachedNetworkImage(
                            imageUrl: imageUrl,
                            fit: BoxFit.cover,
                            height: 120,
                            errorWidget: (context, url, error) {
                              return const Icon(Icons.error);
                            },
                          ),
                          onTap: () {},
                        );
                      }).toList(),
                    ),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 15),
            BuildItem(
              label: LocaleKeys.kName.tr(),
              value: hospital.name,
            ),
            BuildItem(
              label: LocaleKeys.kTel.tr(),
              value: hospital.tel,
              onTap: () async {
                await Utils.openUrl('tel:${hospital.tel ?? ''}');
              },
            ),
            BuildItem(
              label: LocaleKeys.kAddress.tr(),
              value: hospital.address,
            ),
            const Divider(),
            Expanded(
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: CameraPosition(
                  target: LatLng(double.tryParse(hospital.lat ?? '0') ?? 0,
                      double.tryParse(hospital.lng ?? '0') ?? 0),
                  zoom: 15,
                ),
                trafficEnabled: true,
                compassEnabled: true,
                mapToolbarEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                zoomControlsEnabled: false,
                markers: <Marker>{}..add(
                    Marker(
                      markerId: MarkerId(
                          (hospital.lat ?? '0') + (hospital.lat ?? '0')),
                      position: LatLng(
                          double.tryParse(hospital.lat ?? '0') ?? 0,
                          double.tryParse(hospital.lng ?? '0') ?? 0),
                      infoWindow: InfoWindow(
                        title: hospital.name ?? '',
                        snippet: hospital.address ?? '-',
                      ),
                    ),
                  ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
