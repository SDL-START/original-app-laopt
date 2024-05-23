// To parse this JSON data, do
//
//     final slideimageModel = slideimageModelFromJson(jsonString);

import 'dart:convert';

List<SlideimageModel> slideimageModelFromJson(String str) =>
    List<SlideimageModel>.from(
        json.decode(str).map((x) => SlideimageModel.fromJson(x)));

String slideimageModelToJson(List<SlideimageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlideimageModel {
  int id;
  String images;
  bool deleted;

  SlideimageModel({
    required this.id,
    required this.images,
    required this.deleted,
  });

  factory SlideimageModel.fromJson(Map<String, dynamic> json) =>
      SlideimageModel(
        id: json["id"],
        images: json["images"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "images": images,
        "deleted": deleted,
      };
}
