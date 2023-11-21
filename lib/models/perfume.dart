// To parse this JSON data, do
//
//     final perfume = perfumeFromJson(jsonString);

import 'dart:convert';

List<Perfume> perfumeFromJson(String str) => List<Perfume>.from(json.decode(str).map((x) => Perfume.fromJson(x)));

String perfumeToJson(List<Perfume> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Perfume {
    String model;
    int pk;
    Fields fields;

    Perfume({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Perfume.fromJson(Map<String, dynamic> json) => Perfume(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int user;
    String name;
    int price;
    int amount;
    String description;

    Fields({
        required this.user,
        required this.name,
        required this.price,
        required this.amount,
        required this.description,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        user: json["user"],
        name: json["name"],
        price: json["price"],
        amount: json["amount"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "user": user,
        "name": name,
        "price": price,
        "amount": amount,
        "description": description,
    };
}
