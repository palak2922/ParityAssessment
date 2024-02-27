// To parse this JSON data, do
//
//     final popular = popularFromJson(jsonString);

import 'dart:convert';

Popular popularFromJson(String str) => Popular.fromJson(json.decode(str));

String popularToJson(Popular data) => json.encode(data.toJson());

class Popular {
  SeoSettings seoSettings;
  List<Deal> deals;

  Popular({
    required this.seoSettings,
    required this.deals,
  });

  factory Popular.fromJson(Map<String, dynamic> json) => Popular(
    seoSettings: SeoSettings.fromJson(json["seo_settings"]),
    deals: List<Deal>.from(json["deals"].map((x) => Deal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seo_settings": seoSettings.toJson(),
    "deals": List<dynamic>.from(deals.map((x) => x.toJson())),
  };
}

class Deal {
  Deal();

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
  );

  Map<String, dynamic> toJson() => {
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
