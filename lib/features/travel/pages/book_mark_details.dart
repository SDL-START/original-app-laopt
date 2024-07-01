import 'package:flutter/material.dart';
import 'package:insuranceapp/core/models/model_details_add_book_mark.dart';
import 'package:url_launcher/url_launcher.dart';

class BookMarkDetails extends StatelessWidget {
  final ModelAddBookMark famousModel;
  Future<void> _launchGoogleMaps() async {
    var url = famousModel.tourismPlaces.location;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  BookMarkDetails({required this.famousModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          famousModel.tourismPlaces.title,
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 5),
          child: Column(
            children: [
              // Text('Place: ${famousModel.tourismPlaces.title}'),
              // Text('Address: ${famousModel.tourismPlaces.address}'),
              Image.network(
                famousModel.tourismPlaces.featuredImage,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: _launchGoogleMaps,
                    icon: Icon(
                      Icons.location_on_outlined,
                      size: 35,
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.remove_red_eye),
                    ],
                  ),
                ],
              ),
              Text(
                famousModel.tourismPlaces.detail.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
