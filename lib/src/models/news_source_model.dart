// To parse this JSON data, do
//
//     final newsSource = newsSourceFromJson(jsonString);

import 'dart:convert';

NewsSource newsSourceFromJson(String str) =>
    NewsSource.fromJson(json.decode(str));

String newsSourceToJson(NewsSource data) => json.encode(data.toJson());

class NewsSource {
  NewsSource({
    this.status,
    this.sources,
  });

  String status;
  List<SourceNews> sources;

  factory NewsSource.fromJson(Map<String, dynamic> json) => NewsSource(
        status: json["status"],
        sources: List<SourceNews>.from(
            json["sources"].map((x) => SourceNews.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sources": List<dynamic>.from(sources.map((x) => x.toJson())),
      };
}

class SourceNews {
  SourceNews({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country,
  });

  String id;
  String name;
  String description;
  String url;
  Category category;
  String language;
  String country;

  factory SourceNews.fromJson(Map<String, dynamic> json) => SourceNews(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        category: categoryValues.map[json["category"]],
        language: json["language"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "category": categoryValues.reverse[category],
        "language": language,
        "country": country,
      };
}

enum Category {
  GENERAL,
  BUSINESS,
  TECHNOLOGY,
  SPORTS,
  ENTERTAINMENT,
  HEALTH,
  SCIENCE
}

final categoryValues = EnumValues({
  "business": Category.BUSINESS,
  "entertainment": Category.ENTERTAINMENT,
  "general": Category.GENERAL,
  "health": Category.HEALTH,
  "science": Category.SCIENCE,
  "sports": Category.SPORTS,
  "technology": Category.TECHNOLOGY
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
