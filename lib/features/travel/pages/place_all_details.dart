import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_travel_details.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class PlaceAllDetails extends StatefulWidget {
  final ModelTravelDetail famousModel;

  PlaceAllDetails({
    required this.famousModel,
  });

  @override
  State<PlaceAllDetails> createState() => _PlaceAllDetailsState();
}

class _PlaceAllDetailsState extends State<PlaceAllDetails> {
  String? token;
  int? userId;
  bool mounted = true;
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _initializeUserToken();
  }

  @override
  void dispose() {
    // mounted = false;
    mounted = false;
    super.dispose();
  }

  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final Map<String, dynamic> mapUser = jsonDecode(user);
      User data = User.fromJson(mapUser);
      if (mounted) {
        setState(() {
          userId = data.id;
        });
      }
      return data.token;
    }
    return null;
  }

  Future<void> _initializeUserToken() async {
    token = await getUserToken();
    if (token == null) {
      print('Error: User token is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: User not logged in or token missing',
          ),
        ),
      );
    }
  }

  Future<void> _launchGoogleMaps() async {
    var url = widget.famousModel.location;
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

//add bookmark
  Future<void> _toggleBookmark() async {
    if (token == null) {
      print('Token is not available');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: Token is not available'),
        ),
      );
      return;
    }

    String url = isBookmarked
        ? '${APIPath.baseUrl}tourism/bookmark/add'
        : '${APIPath.baseUrl}tourism/bookmark/add';

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          "tourism_id": widget.famousModel.id,
          "user_id": userId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var result = jsonDecode(response.body);
        print("API Response: $result");

        if (result['result'] == 'OK') {
          setState(() {
            isBookmarked = !isBookmarked;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(
                child: Text(
                  isBookmarked
                      ? 'add to bookmark success!'
                      : 'remove from bookmark success!',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        } else {
          throw Exception('Failed to update bookmark');
        }
      } else {
        print(
          "Failed to update bookmark. Status code: ${response.statusCode}",
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Failed to update bookmark. Error: ${response.reasonPhrase}',
            ),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.famousModel.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Image.network(widget.famousModel.featuredImage),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        Text(widget.famousModel.views.toString()),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: _toggleBookmark,
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 35,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                children: [
                  Text(widget.famousModel.detail),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
