import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class BookMarkDetails extends StatefulWidget {
  const BookMarkDetails({super.key});

  @override
  State<BookMarkDetails> createState() => _BookMarkDetailsState();
}

class _BookMarkDetailsState extends State<BookMarkDetails> {
  Widget build(BuildContext context) {
    //  List<Widget> images =
    //     .map((url) => Image.network(
    //           url,
    //           fit: BoxFit.cover,
    //         ))
    //     .toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('More Details'),
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
                // children: images,
                children: [],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
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
              Text("details"),
            ],
          ),
        ),
      ),
    );
  }
}
