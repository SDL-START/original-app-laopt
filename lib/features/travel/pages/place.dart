import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_province_all.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/pages/place_all.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Place extends StatefulWidget {
  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  List<ModelProvinceAll> modelprovince = const [];
  bool loading = false;

  Future<void> initialDataProvice() async {
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
    // print('object-------');
    setState(() {
      loading = true;
    });
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
          'GET', Uri.parse(APIPath.baseUrl + '/tourism/get/provinces'));
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        final data = await response.stream.bytesToString();
        // print("object---444----$data");
        // modelprovince = modelProvinceAllFromJson(data);

        setState(() {
          modelprovince = modelProvinceAllFromJson(data);
        });

        print("Hello $modelprovince");
        // print('data=== $famousList');
      } else {
        print('Error===${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error===$e');
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    // log('initState...' );
    initialDataProvice();
  }

  bool mounted = true;
  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.green[900],
        title: Text(
          LocaleKeys.KPopularplace.tr(),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: modelprovince.length,
            itemBuilder: (BuildContext context, int index) {
              // print("BuildContext");
              final data = modelprovince[index];
              print('object $data');
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 5,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlaceAll(
                          MmodelProvinceAll: data,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            data.name.us.toString(),
                          ),
                        ),
                        CarouselSlider(
                          options: CarouselOptions(
                            height: 200,
                            aspectRatio: 2,
                            viewportFraction: 1.0,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            onPageChanged: (index, reason) {
                              // Do something when page changes
                            },
                            scrollDirection: Axis.horizontal,
                            // Adding dots
                            // Set dots to true to show the dots at the bottom
                            // Set dots to false if you don't want to show dots
                            // dots: true,
                          ),
                          items:
                              modelprovince[index].tourismCoverImage.map((url) {
                            return Builder(
                              builder: (BuildContext context) {
                                return ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15.0),
                                    bottom: Radius.circular(15.0),
                                  ),
                                  child: Image.network(
                                    url.images,
                                    fit: BoxFit.cover,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
