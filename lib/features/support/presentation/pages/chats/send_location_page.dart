import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insuranceapp/core/constants/constant.dart';
import 'package:insuranceapp/core/widgets/loading_widget.dart';
import 'package:insuranceapp/features/support/presentation/cubit/chat_cubit/chat_cubit.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/app_navigator.dart';

class SendLocationPage extends StatelessWidget {
  const SendLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        title: const Text(
          'Send location',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            previous.currentLocation != current.currentLocation,
        builder: (context, state) {
          if (state.status == DataStatus.loading) {
            return const LoadingWidget();
          }
          return SlidingUpPanel(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 20),
            color: Colors.white.withOpacity(0.9),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            maxHeight: MediaQuery.of(context).size.height / 3,
            minHeight: MediaQuery.of(context).size.height / 5,
            panel: Column(
              children: [
                // TextButton(
                //   onPressed: () async {
                //     //   await context.read<ChatCubit>().sendMessage(
                //     //       receiverId: state.ticket?.sosInfo?.user?.id,
                //     //       ticketId: state.ticket?.ticketId,
                //     //       messageType: MessageType.LIVE_LOCATION,
                //     // );liveLocation
                //     // AppNavigator.goBack();
                //      context.read<ChatCubit>().liveLocation();
                //   },
                //   child: Text("Send live location"),
                // ),
                const Divider(),
                Card(
                  color: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: InkWell(
                    onTap: ()async{
                      await context.read<ChatCubit>().sendMessage(
                          receiverId: state.ticket?.sosInfo?.user?.id,
                          ticketId: state.ticket?.ticketId,
                          messageType: MessageType.LOCATION,
                    );
                    AppNavigator.goBack();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 45,
                      child: const Center(
                        child: Text(
                          "Send your current location",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.currentLocation?.latitude ?? 0,
                        state.currentLocation?.longitude ?? 0),
                    zoom: 16,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  markers: {
                    Marker(
                        markerId: MarkerId("${state.ticket?.ticketId}"),
                        position: LatLng(state.currentLocation?.latitude ?? 0,
                            state.currentLocation?.longitude ?? 0))
                  },
                  onMapCreated: (GoogleMapController controller) {
                    context
                        .read<ChatCubit>()
                        .mapController
                        .complete(controller);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    await context.read<ChatCubit>().currentPosition();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(15),
                      backgroundColor: Colors.white),
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
              ],
            ),
          );
          // return Stack(
          //   children: [
          //     GoogleMap(
          //       initialCameraPosition: CameraPosition(
          //         target: LatLng(state.currentLocation?.latitude ?? 0,
          //             state.currentLocation?.longitude ?? 0),
          //         zoom: 16,
          //       ),
          //       myLocationEnabled: true,
          //       myLocationButtonEnabled: false,
          //       markers: {
          //         Marker(
          //             markerId: MarkerId("${state.ticket?.ticketId}"),
          //             position: LatLng(state.currentLocation?.latitude ?? 0,
          //                 state.currentLocation?.longitude ?? 0))
          //       },
          //       onMapCreated: (GoogleMapController controller) {
          //         context.read<ChatCubit>().mapController.complete(controller);
          //       },
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.only(top: 20),
          //       child: Align(
          //         alignment: Alignment.topRight,
          //         child: ElevatedButton(
          //           onPressed: () async {
          //             await context.read<ChatCubit>().currentPosition();
          //           },
          //           style: ElevatedButton.styleFrom(
          //               shape: const CircleBorder(),
          //               padding: const EdgeInsets.all(15),
          //               backgroundColor: Colors.white),
          //           child: const Icon(
          //             Icons.my_location,
          //             color: Colors.grey,
          //             size: 20,
          //           ),
          //         ),
          //       ),
          //     ),
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: SafeArea(
          //         child: Card(
          //           color: AppColors.primaryColor,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(10)),
          //           child: InkWell(
          //             onTap: () async {
          //               await context.read<ChatCubit>().sendMessage(
          //                     receiverId: state.ticket?.sosInfo?.user?.id,
          //                     ticketId: state.ticket?.ticketId,
          //                     messageType: MessageType.LOCATION,
          //                   );

          //               AppNavigator.goBack();
          //             },
          //             child: Container(
          //               padding: const EdgeInsets.all(10),
          //               width: MediaQuery.of(context).size.width / 1.2,
          //               height: 45,
          //               child: const Center(
          //                 child: Text(
          //                   "Send your current location",
          //                   style: TextStyle(
          //                     color: Colors.white,
          //                     fontWeight: FontWeight.bold,
          //                     fontSize: 14,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     )
          //   ],
          // );
        },
      ),
    );
  }
}
