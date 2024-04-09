// To parse this JSON data, do
//
//     final vendorDjModel = vendorDjModelFromJson(jsonString);

import 'dart:convert';

VendorDjModel vendorDjModelFromJson(String str) => VendorDjModel.fromJson(json.decode(str));

String vendorDjModelToJson(VendorDjModel data) => json.encode(data.toJson());

class VendorDjModel {
  List<Result> result;
  String status;

  VendorDjModel({
    required this.result,
    required this.status,
  });

  factory VendorDjModel.fromJson(Map<String, dynamic> json) => VendorDjModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "status": status,
  };
}

class Result {
  int id;
  int siteUserId;
  int profileId;
  String djName;
  String vendorName;
  int package;
  String locality;
  String city;
  String state;
  String pincode;
  int rating;
  String experience;
  String coverImage;
  String images;
  String status;
  String remark;
  DateTime updatedDate;
  DateTime creationDate;

  Result({
    required this.id,
    required this.siteUserId,
    required this.profileId,
    required this.djName,
    required this.vendorName,
    required this.package,
    required this.locality,
    required this.city,
    required this.state,
    required this.pincode,
    required this.rating,
    required this.experience,
    required this.coverImage,
    required this.images,
    required this.status,
    required this.remark,
    required this.updatedDate,
    required this.creationDate,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    siteUserId: json["site_user_id"],
    profileId: json["profile_id"],
    djName: json["dj_name"],
    vendorName: json["vendor_name"],
    package: json["package"],
    locality: json["locality"],
    city: json["city"],
    state: json["state"],
    pincode: json["pincode"],
    rating: json["rating"],
    experience: json["experience"],
    coverImage: json["cover_image"],
    images: json["images"],
    status: json["status"],
    remark: json["remark"],
    updatedDate: DateTime.parse(json["updated_date"]),
    creationDate: DateTime.parse(json["creation_date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "site_user_id": siteUserId,
    "profile_id": profileId,
    "dj_name": djName,
    "vendor_name": vendorName,
    "package": package,
    "locality": locality,
    "city": city,
    "state": state,
    "pincode": pincode,
    "rating": rating,
    "experience": experience,
    "cover_image": coverImage,
    "images": images,
    "status": status,
    "remark": remark,
    "updated_date": updatedDate.toIso8601String(),
    "creation_date": creationDate.toIso8601String(),
  };
}
