// To parse this JSON data, do
//
//     final featured = featuredFromJson(jsonString);

import 'dart:convert';

Featured featuredFromJson(String str) => Featured.fromJson(json.decode(str));

String featuredToJson(Featured data) => json.encode(data.toJson());

class Featured {
  SeoSettings seoSettings;
  List<Deal> deals;

  Featured({
    required this.seoSettings,
    required this.deals,
  });

  factory Featured.fromJson(Map<String, dynamic> json) => Featured(
    seoSettings: SeoSettings.fromJson(json["seo_settings"]),
    deals: List<Deal>.from(json["deals"].map((x) => Deal.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "seo_settings": seoSettings.toJson(),
    "deals": List<dynamic>.from(deals.map((x) => x.toJson())),
  };
}

class Deal {
  String permalink;
  String title;

  Deal({
    required this.permalink,
    required this.title,
  });

  factory Deal.fromJson(Map<String, dynamic> json) => Deal(
    permalink: json["permalink"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "permalink": permalink,
    "title": title,
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
