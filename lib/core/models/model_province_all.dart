// To parse this JSON data, do
//
//     final modelProvinceAll = modelProvinceAllFromJson(jsonString);

import 'dart:convert';

List<ModelProvinceAll> modelProvinceAllFromJson(String str) =>
    List<ModelProvinceAll>.from(
        json.decode(str).map((x) => ModelProvinceAll.fromJson(x)));

String modelProvinceAllToJson(List<ModelProvinceAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelProvinceAll {
  final int id;
  final Name name;
  final List<TourismCoverImage> tourismCoverImage;

  ModelProvinceAll({
    required this.id,
    required this.name,
    required this.tourismCoverImage,
  });

  factory ModelProvinceAll.fromJson(Map<String, dynamic> json) =>
      ModelProvinceAll(
        id: json["id"],
        name: Name.fromJson(json["name"]),
        tourismCoverImage: List<TourismCoverImage>.from(
            json["tourism_cover_image"]
                .map((x) => TourismCoverImage.fromJson(x))),
      );

  get modelprovince => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name.toJson(),
        "tourism_cover_image":
            List<dynamic>.from(tourismCoverImage.map((x) => x.toJson())),
      };
}

class Name {
  final String us;

  Name({
    required this.us,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        us: json["us"],
      );

  Map<String, dynamic> toJson() => {
        "us": us,
      };
}

class TourismCoverImage {
  final String images;

  TourismCoverImage({
    required this.images,
  });

  factory TourismCoverImage.fromJson(Map<String, dynamic> json) =>
      TourismCoverImage(
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "images": images,
      };
}
