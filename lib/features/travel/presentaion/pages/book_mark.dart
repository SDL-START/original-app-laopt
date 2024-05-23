import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_details_add_book_mark.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/presentaion/pages/book_mark_details.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMark extends StatefulWidget {
  BookMark({super.key});

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  bool loading = false;
  List<ModelAddBookMark> save = const [];
  bool isError = false;
  String messageError = '';
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
  int? userId;
  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    final Map<String, dynamic>? mapUser = user == null ? {} : jsonDecode(user);
    User data = User.fromJson(mapUser ?? {});
    print('token===${data.token}');
    if (mounted) {
      setState(() {
        token = data.token;
        userId = data.id;
      });
    }
    return data.token;
  }

  Future<void> fetchData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var request = http.Request(
          'POST', Uri.parse(APIPath.baseUrl + '/tourism/bookmarks'));
      request.body = json.encode({"user_id": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        // print(await response.stream.bytesToString());
        final data = await response.stream.bytesToString();
        print(data);
        save = modelAddBookMarkFromJson(data);
        print(save);
        if (mounted) {
          setState(() {});
        }

        // print('data=== $save');
      } else {
        setState(() {
          isError = true;
          messageError = response.reasonPhrase.toString();
        });
        print('Error===${response.reasonPhrase}');
      }
    } catch (e) {
      setState(() {
        isError = true;
        messageError = e.toString();
      });
      print('Error===$e');
    }
  }

  @override
  void initState() {
    super.initState();
    // print('initState...');
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
        title: Text(
          LocaleKeys.kSave.tr(),
        ),
      ),
      body: Builder(
        builder: (context) {
          if (loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (isError) {
            if (messageError == 'Network is unreachable') {
              return Center(
                child: Text('ບໍ່ມີອິນເຕີເນັດ'),
              );
            }
            return Center(
              child: Text('Something went wrong: $messageError'),
            );
          }
          if (save.isEmpty) {
            return Center(
              child: Image(
                height: 100,
                width: 100,
                image: AssetImage("assets/package.png"),
              ),
            );
          }
          return ListView.builder(
            itemCount: save.length,
            itemBuilder: (context, index) {
              var saves = save[index];
              return Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  top: 5,
                ),
                child: Card(
                  child: ListTile(
                    leading: Image.network(
                      saves.tourismPlaces.featuredImage,
                      width: 70,
                      height: 70,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        }
                      },
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return Icon(Icons.error, color: Colors.red);
                      },
                    ),
                    subtitle: Text(
                      saves.tourismPlaces.title,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        // print('object---->1111000');
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      saves.tourismPlaces.address,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookMarkDetails(),
                        ),
                      );
                    },
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
