// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_province_all.dart';
import 'package:insuranceapp/core/models/model_travel_details.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/presentaion/pages/place_all_details.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaceAll extends StatefulWidget {
  final ModelProvinceAll MmodelProvinceAll;
  PlaceAll({
    Key? key,
    required this.MmodelProvinceAll,
  }) : super(key: key);

  @override
  State<PlaceAll> createState() => _PlaceAllState();
}

class _PlaceAllState extends State<PlaceAll> {
  bool loading = false;
  List<ModelTravelDetail> famousList = const [];

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
      var request = http.Request(
        'GET',
        Uri.parse(APIPath.baseUrl + '/tourism/get/by/province/1'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        //print(await response.stream.bytesToString());
        final data = await response.stream.bytesToString();
        print("Hello world {$data}");
        famousList = ModelTravelDetailFromJson(data);
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
    print('initState...');
    initialData();
    // initialDataSilde();
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
        backgroundColor: Colors.green[900],
        title: Text(widget.MmodelProvinceAll.name.us),
      ),
      body: ListView.builder(
        itemCount: famousList.length,
        itemBuilder: (context, index) {
          var data = famousList[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaceAllDetails(
                      imageUrl: data,
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
                        data.title.toString(),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                          15.0,
                        ),
                      ),
                      child: Image.network(
                        data.featuredImage,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          LocaleKeys.kdetails.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
