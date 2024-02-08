import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/models/ticket.dart';
import 'package:insuranceapp/core/utils/utils.dart';

class MapBarWidget extends StatelessWidget {
  final Ticket? ticket;
  final Function()? onTap;
  const MapBarWidget({super.key, this.ticket,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl:
                  Utils.getPhoto(val: ticket?.user?.photo ?? '').photoprofile ??
                      '',
              imageBuilder: (context, imageProvider) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration:const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
            const SizedBox(width: 20),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${ticket?.user?.firstname} ${ticket?.user?.lastname}"),
                Text(ticket?.user?.phone ?? ''),
                Text(ticket?.user?.email ?? ''),
                Text(ticket?.description ?? ''),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
