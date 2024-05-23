import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:insuranceapp/core/models/famou_model.dart';
import 'package:url_launcher/url_launcher.dart';

class PopularPlaceDetail extends StatelessWidget {
  final FamouModel famousModel; // Add this line

  PopularPlaceDetail({
    required this.famousModel,
  }); // Update constructor
  Future<void> _launchGoogleMaps() async {
    var url = famousModel.location;
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> images = famousModel.photo
        .map((url) => Image.network(
              url,
              fit: BoxFit.cover,
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            Text(famousModel.title), // Use the item name in the app bar title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 15.0, left: 15, top: 5),
          child: Column(
            children: [
              ImageSlideshow(
                indicatorColor: Colors.blue,
                autoPlayInterval: 3000,
                isLoop: true,
                children: images,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchGoogleMaps();
                    },
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark,
                      size: 35,
                    ),
                  )
                ],
              ),
              Text(
                famousModel.detail.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
