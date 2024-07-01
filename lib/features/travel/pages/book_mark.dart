import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:insuranceapp/core/constants/api_path.dart';
import 'package:insuranceapp/core/models/model_details_add_book_mark.dart';
import 'package:insuranceapp/core/models/user.dart';
import 'package:insuranceapp/features/travel/pages/book_mark_details.dart';
import 'package:insuranceapp/generated/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookMark extends StatefulWidget {
  const BookMark({Key? key}) : super(key: key);

  @override
  State<BookMark> createState() => _BookMarkState();
}

class _BookMarkState extends State<BookMark> {
  bool loading = false;
  List<ModelAddBookMark> save = [];
  bool isError = false;
  String messageError = '';

  @override
  void initState() {
    super.initState();
    initialData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initialData() async {
    setState(() {
      loading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    await getUserToken();
    await fetchData();
    setState(() {
      loading = false;
    });
  }

  String? token;
  int? userId;

  Future<String?> getUserToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final user = prefs.getString('user');
    if (user != null) {
      final Map<String, dynamic> mapUser = jsonDecode(user);
      User data = User.fromJson(mapUser);
      setState(() {
        token = data.token;
        userId = data.id;
      });
      return data.token;
    }
    return null;
  }

  Future<void> fetchData() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.Request(
        'POST',
        Uri.parse('${APIPath.baseUrl}/tourism/bookmarks'),
      );
      request.body = json.encode({"user_id": userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        final data = await response.stream.bytesToString();
        setState(() {
          save = modelAddBookMarkFromJson(data);
        });
      } else {
        setState(() {
          isError = true;
          messageError = response.reasonPhrase.toString();
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        messageError = e.toString();
      });
    }
  }

  Future<void> deleteBookmark(int id) async {
    try {
      setState(() {
        isError = false;
      });
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      var request = http.Request(
        'POST',
        Uri.parse(
          '${APIPath.baseUrl}/tourism/bookmark/delete/$id',
          // bookmark / delete tourism/bookmarks
        ),
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      print("object ${response.statusCode}");

      if (response.statusCode == 200) {
        setState(() {
          save.removeWhere((bookmark) => bookmark.id == id);
        });
      } else {
        setState(() {
          isError = true;
          messageError = response.reasonPhrase.toString();
        });
      }
    } catch (e) {
      print('delete $e');
      setState(() {
        isError = true;
        messageError = e.toString();
      });
    }
  }

  void confirmDelete(BuildContext context, int id) {
    print("object----- ${id}");
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(tr('Confirm Deletion')),
          content: Text(tr('Are you sure you want to delete this bookmark?')),
          actions: <Widget>[
            TextButton(
              child: Text(tr('Cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(tr('Delete')),
              onPressed: () {
                deleteBookmark(id);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green[900],
        title: Text(LocaleKeys.kSave.tr()),
      ),
      body: Builder(
        builder: (context) {
          if (loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (isError) {
            return Center(
              child: Text('Something went wrong: $messageError'),
            );
          }
          if (save.isEmpty) {
            return const Center(
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
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 5),
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
                        return const Icon(Icons.error, color: Colors.red);
                      },
                    ),
                    subtitle: Text(saves.tourismPlaces.title),
                    trailing: IconButton(
                      onPressed: () {
                        confirmDelete(context, saves.id);
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                    title: Text(saves.tourismPlaces.address),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookMarkDetails(
                            famousModel: saves,
                          ),
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
