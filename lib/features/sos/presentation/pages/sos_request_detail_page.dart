import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/sos/presentation/cubit/sos_cubit.dart';

import '../../../../core/utils/utils.dart';

class SOSRequestDetail extends StatelessWidget {
  final Ticket ticket;
  const SOSRequestDetail({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("TicketID: ${ticket.ticketId}"),
      ),
      body: BlocBuilder<SosCubit, SosState>(
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: GoogleMap(
                    mapType: MapType.satellite,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(ticket.lat ?? 0,ticket.lng ?? 0),
                      zoom: 18,
                    ),
                    markers: <Marker>{
                      Marker(
                        markerId: MarkerId(ticket.lng.toString()),
                        position: LatLng(ticket.lat ?? 0,ticket.lng ?? 0),
                      ),
                    },
                  ),
                ),
                Container(
                  height: 30,
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16, top: 8),
                  color: Colors.grey.shade200,
                  child: const Text('History'),
                ),
                Column(
                  children: List.generate(state.listTicket.length, (index) {
                    final item = state.listTicket[index];
                    return ListTile(
                      leading: const Icon(
                        Icons.access_time_outlined,
                        size: 30,
                      ),
                      title: Text(Utils.formatDateTime(
                          item.createdAt?.toLocal().toIso8601String())),
                      subtitle: Text(item.description ?? ''),
                      trailing: Container(
                        color: Utils.getSosColorByStatus(item.status ?? ''),
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 2, left: 4, right: 4),
                        child: Text(
                          item.status ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
