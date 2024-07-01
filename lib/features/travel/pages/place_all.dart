import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_province_all.dart';
import 'package:insuranceapp/core/models/model_travel_details.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/pages/place_all_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';

class PlaceAll extends StatefulWidget {
  final ModelProvinceAll MmodelProvinceAll;

  PlaceAll({
    Key? key,
    required this.MmodelProvinceAll,
  }) : super(key: key);

  @override
  _PlaceAllState createState() => _PlaceAllState();
}

class _PlaceAllState extends State<PlaceAll> {
  bool loading = false;
  List<ModelTravelDetail> famousList = [];

  Future<void> initialData() async {
    setState(() {
      loading = true;
    });

    await getUserToken();
    await fetchData();

    setState(() {
      loading = false;
    });
  }

  String? token;

  Future<String?> getUserToken() async {
    final prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final mapUser = user == null ? {} : jsonDecode(user);
    final data = User.fromJson(mapUser ?? {});

    setState(() {
      token = data.token;
    });

    return data.token;
  }

  Future<void> fetchData() async {
    if (token == null) return;

    try {
      final headers = {'Authorization': 'Bearer $token'};
      final url = APIPath.baseUrl +
          '/tourism/get/by/province/' +
          widget.MmodelProvinceAll.id.toString();
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = response.body;
        setState(() {
          famousList = ModelTravelDetailFromJson(data);
        });
      } else {
        // Handle server errors
        print('Server error: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Handle exceptions
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    initialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text(widget.MmodelProvinceAll.name.us),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: famousList.length,
              itemBuilder: (context, index) {
                final data = famousList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaceAllDetails(
                            // famousModel: data,
                            famousModel: data,
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
                            child: Text(data.title.toString()),
                          ),
                          ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(15.0),
                            ),
                            child: Image.network(
                              data.featuredImage,
                              fit: BoxFit.cover,
                              height: 200,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Center(
                                    child: Text('Image failed to load'));
                              },
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
