// To parse this JSON data, do
//
//     final ModelTravelDetail = ModelTravelDetailFromJson(jsonString);

import 'dart:convert';

List<ModelTravelDetail> ModelTravelDetailFromJson(String str) =>
    List<ModelTravelDetail>.from(
        json.decode(str).map((x) => ModelTravelDetail.fromJson(x)));

String ModelTravelDetailToJson(List<ModelTravelDetail> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelTravelDetail {
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

  ModelTravelDetail({
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

  factory ModelTravelDetail.fromJson(Map<String, dynamic> json) =>
      ModelTravelDetail(
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
