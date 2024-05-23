import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/famou_model.dart';
import 'package:insuranceapp/core/models/slide_model.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/presentaion/pages/popular_place_detail.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PopularPlace extends StatefulWidget {
  PopularPlace({super.key});

  @override
  State<PopularPlace> createState() => _PopularPlaceState();
}

class _PopularPlaceState extends State<PopularPlace> {
  final List<String> imageUrls = [];

  List<FamouModel> famousList = const [];
  List<SlideimageModel> slideimageModel = const [];
  bool loading = false;

  Future<void> initialDataSilde() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    Future.delayed(const Duration(seconds: 2), () async {
      await getUserToken();
      await fetchdataslide();
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  Future<void> fetchdataslide() async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
        'GET',
        Uri.parse(APIPath.baseUrl + '/tourism/slide/image'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        final data = await response.stream.bytesToString();
        slideimageModel = slideimageModelFromJson(data);
        // print("$slideimageModel");
        if (mounted) {
          setState(() {});
        }

        // print('data=== $famousList');
      } else {
        log('Error===${response.reasonPhrase}');
      }
    } catch (e) {
      log('Error===$e');
    }
  }

////////
  Future<void> initialData() async {
    if (mounted) {
      setState(() {
        loading = true;
      });
    }
    Future.delayed(const Duration(seconds: 2), () async {
      await getUserToken();
      await fetchData();
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    });
  }

  String? token;
  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final Map<String, dynamic>? mapUser = user == null ? {} : jsonDecode(user);
    User data = User.fromJson(mapUser ?? {});
    // log('token===${data.token}');
    if (mounted) {
      setState(() {
        token = data.token;
      });
    }
    return data.token;
  }

  Future<void> fetchData() async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request =
          http.Request('GET', Uri.parse(APIPath.baseUrl + '/tourism/famous'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        final data = await response.stream.bytesToString();
        famousList = famouModelFromJson(data);
        if (mounted) {
          setState(() {});
        }

        // print('data=== $famousList');
      } else {
        // log('Error===${response.reasonPhrase}');
      }
    } catch (e) {
      // log('Error===$e');
    }
  }

  @override
  void initState() {
    super.initState();
    log('initState...');
    initialData();
    initialDataSilde();
  }

  bool mounted = true;
  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('build context...');
    List<Widget> images = slideimageModel
        .map((url) => Image.network(
              url.images,
              fit: BoxFit.cover,
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green[900],
        title: Text(
          LocaleKeys.KTouristplaces.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Builder(builder: (context) {
        if (loading) {
          return Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 5,
          ),
          child: Column(
            children: [
              ImageSlideshow(
                // indicatorBottomPadding: 10,
                indicatorRadius: 5,
                height: 170,
                indicatorColor: Colors.black,
                autoPlayInterval: 3000,
                isLoop: true,
                children: images,
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 5.0, // Spacing between columns
                    mainAxisSpacing: 5.0, // Spacing between rows
                  ),
                  itemCount: famousList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = famousList[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PopularPlaceDetail(
                              famousModel: data,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            data.title.toString(),
                          ),
                          Card(
                            color: Colors.white,
                            child: Image.network(
                              fit: BoxFit.cover,
                              data.featuredImage,
                              height: 100,
                              width: 170,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
