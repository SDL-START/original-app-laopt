// To parse this JSON data, do
//
//     final modelAddBookMark = modelAddBookMarkFromJson(jsonString);

import 'dart:convert';

List<ModelAddBookMark> modelAddBookMarkFromJson(String str) =>
    List<ModelAddBookMark>.from(
        json.decode(str).map((x) => ModelAddBookMark.fromJson(x)));

String modelAddBookMarkToJson(List<ModelAddBookMark> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelAddBookMark {
  int id;
  int userId;
  int tourismId;
  TourismPlaces tourismPlaces;

  ModelAddBookMark({
    required this.id,
    required this.userId,
    required this.tourismId,
    required this.tourismPlaces,
  });

  factory ModelAddBookMark.fromJson(Map<String, dynamic> json) =>
      ModelAddBookMark(
        id: json["id"],
        userId: json["user_id"],
        tourismId: json["tourism_id"],
        tourismPlaces: TourismPlaces.fromJson(json["tourism_places"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "tourism_id": tourismId,
        "tourism_places": tourismPlaces.toJson(),
      };
}

class TourismPlaces {
  int id;
  String title;
  String detail;
  String address;
  String featuredImage;
  List<String> photo;
  int provinceId;
  int userId;
  bool isfamous;
  String lat;
  String lng;
  String location;
  int views;
  bool deleted;
  DateTime createdtime;

  TourismPlaces({
    required this.id,
    required this.title,
    required this.detail,
    required this.address,
    required this.featuredImage,
    required this.photo,
    required this.provinceId,
    required this.userId,
    required this.isfamous,
    required this.lat,
    required this.lng,
    required this.location,
    required this.views,
    required this.deleted,
    required this.createdtime,
  });

  factory TourismPlaces.fromJson(Map<String, dynamic> json) => TourismPlaces(
        id: json["id"],
        title: json["title"],
        detail: json["detail"],
        address: json["address"],
        featuredImage: json["featured_image"],
        photo: List<String>.from(json["photo"].map((x) => x)),
        provinceId: json["province_id"],
        userId: json["user_id"],
        isfamous: json["isfamous"],
        lat: json["lat"],
        lng: json["lng"],
        location: json["location"],
        views: json["views"],
        deleted: json["deleted"],
        createdtime: DateTime.parse(json["createdtime"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "detail": detail,
        "address": address,
        "featured_image": featuredImage,
        "photo": List<dynamic>.from(photo.map((x) => x)),
        "province_id": provinceId,
        "user_id": userId,
        "isfamous": isfamous,
        "lat": lat,
        "lng": lng,
        "location": location,
        "views": views,
        "deleted": deleted,
        "createdtime": createdtime.toIso8601String(),
      };
}
