// To parse this JSON data, do
//
//     final top = topFromJson(jsonString);

import 'dart:convert';

Top topFromJson(String str) => Top.fromJson(json.decode(str));

String topToJson(Top data) => json.encode(data.toJson());

class Top {
  SeoSettings? seoSettings;
  List<Deal> deals;

  Top({
    required this.seoSettings,
    required this.deals,
  });

  factory Top.fromJson(Map<String, dynamic> json) => Top(
    seoSettings: SeoSettings.fromJson(json["seo_settings"]),
    deals: List<Deal>.from(json["deals"].map((x) => Deal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seo_settings": seoSettings!.toJson(),
    "deals": List<dynamic>.from(deals.map((x) => x.toJson())),
  };
}

class Deal {
  int id;
  int commentsCount;
  DateTime createdAt;
  int createdAtInMillis;
  String imageMedium;
  Store? store;

  Deal({
    required this.id,
    required this.commentsCount,
    required this.createdAt,
    required this.createdAtInMillis,
    required this.imageMedium,
    required this.store,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    id: json["id"],
    commentsCount: json["comments_count"],
    createdAt: DateTime.parse(json["created_at"]),
    createdAtInMillis: json["created_at_in_millis"],
    imageMedium: json["image_medium"],
    store: json["store"] == null ? null : Store.fromJson(json["store"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "comments_count": commentsCount,
    "created_at": createdAt.toIso8601String(),
    "created_at_in_millis": createdAtInMillis,
    "image_medium": imageMedium,
    "store": store?.toJson(),
  };
}

class Store {
  String name;

  Store({
    required this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}

class SeoSettings {
  String seoTitle;
  String seoDescription;
  String webUrl;

  SeoSettings({
    required this.seoTitle,
    required this.seoDescription,
    required this.webUrl,
  });

  factory SeoSettings.fromJson(Map<String, dynamic> json) => SeoSettings(
    seoTitle: json["seo_title"],
    seoDescription: json["seo_description"],
    webUrl: json["web_url"],
  );

  Map<String, dynamic> toJson() => {
    "seo_title": seoTitle,
    "seo_description": seoDescription,
    "web_url": webUrl,
  };
}
