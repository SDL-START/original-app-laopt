//save to bookmark
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:insuranceapp/core/models/model_travel_details.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceAllDetails extends StatelessWidget {
  final ModelTravelDetail imageUrl;
  const PlaceAllDetails({
    required this.imageUrl,
  });
  Future<void> _launchGoogleMaps() async {
    var url = imageUrl.location;
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
    List<Widget> images = imageUrl.photo
        .map((url) => Image.network(
              url,
              fit: BoxFit.cover,
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(imageUrl.title), // Use the item name in the app bar title
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
                imageUrl.detail.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// import 'package:insuranceapp/core/models/model_travel_details.dart';
// import 'package:url_launcher/url_launcher.dart';

// class PopularPlaceDetail extends StatelessWidget {
//   final ModelTravelDetail imageUrl; // Add this line

//   PopularPlaceDetail({
//     required this.imageUrl,
//   }); // Update constructor
//   Future<void> _launchGoogleMaps() async {
//     var url = imageUrl.location;
//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<Widget> images = imageUrl.photo
//         .map((url) => Image.network(
//               url,
//               fit: BoxFit.cover,
//             ))
//         .toList();
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text(imageUrl.title), // Use the item name in the app bar title
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(right: 15.0, left: 15, top: 5),
//           child: Column(
//             children: [
//               ImageSlideshow(
//                 indicatorColor: Colors.blue,
//                 autoPlayInterval: 3000,
//                 isLoop: true,
//                 children: images,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   IconButton(
//                     onPressed: () {
//                       _launchGoogleMaps();
//                     },
//                     icon: Icon(
//                       Icons.location_on_outlined,
//                       size: 35,
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(
//                       Icons.bookmark,
//                       size: 35,
//                     ),
//                   )
//                 ],
//               ),
//               Text(
//                 imageUrl.detail.toString(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
