// To parse this JSON data, do
//
//     final bookModel = bookModelFromJson(jsonString);

import 'dart:convert';

BookModel bookModelFromJson(String str) => BookModel.fromJson(json.decode(str));

String bookModelToJson(BookModel data) => json.encode(data.toJson());

class BookModel {
  List<Result> result;
  String status;

  BookModel({
    required this.result,
    required this.status,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) => BookModel(
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "status": status,
  };
}

class Result {
  final int? id;
  final String book;
  final int price;

  Result({
    this.id,
    required this.book,
    required this.price,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    book: json["book"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "book": book,
    "price": price,
  };
}
