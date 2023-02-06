class ImagesResponse {
  bool success = false;
  List<SingleImagesItem> images = [];

  ImagesResponse({required this.success, required this.images});

  ImagesResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["images"] is List) {
      images = (json["images"] as List)
          .map((e) => SingleImagesItem.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    data["images"] = images.map((e) => e.toJson()).toList();

    return data;
  }
}

class SingleImagesItem {
  String? id;
  String? name;
  String? path;
  int likes = 0;
  int downloads = 0;
  int views = 0;
  bool isLiked = false;
  Category? category;
  List<TagColors>? tagColors;
  List<Tags>? tags;
  String? createdAt;
  String? updatedAt;
  int? v;

  SingleImagesItem.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["path"] is String) {
      path = json["path"];
    }
    if (json["likes"] is int) {
      likes = json["likes"];
    }
    if (json["isLiked"] is bool) {
      likes = json["isLiked"];
    }
    if (json["downloads"] is int) {
      downloads = json["downloads"];
    }
    if (json["views"] is int) {
      views = json["views"];
    }
    if (json["category"] is Map) {
      category =
          json["category"] == null ? null : Category.fromJson(json["category"]);
    }
    if (json["colors"] is List) {
      tagColors = json["colors"] == null
          ? null
          : (json["colors"] as List).map((e) => TagColors.fromJson(e)).toList();
    }
    if (json["tags"] is List) {
      tags = json["tags"] == null
          ? null
          : (json["tags"] as List).map((e) => Tags.fromJson(e)).toList();
    }
    if (json["createdAt"] is String) {
      createdAt = json["createdAt"];
    }
    if (json["updatedAt"] is String) {
      updatedAt = json["updatedAt"];
    }
    if (json["__v"] is int) {
      v = json["__v"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["path"] = path;
    data["likes"] = likes;
    data["isLiked"] = isLiked;
    data["downloads"] = downloads;
    data["views"] = views;
    if (category != null) {
      data["category"] = category?.toJson();
    }
    if (tagColors != null) {
      data["colors"] = tagColors?.map((e) => e.toJson()).toList();
    }
    if (tags != null) {
      data["tags"] = tags?.map((e) => e.toJson()).toList();
    }
    data["createdAt"] = createdAt;
    data["updatedAt"] = updatedAt;
    data["__v"] = v;
    return data;
  }
}

class Tags {
  String? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    return data;
  }
}

class TagColors {
  String? id;
  String? code;
  String? name;

  TagColors.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["code"] is String) {
      code = json["code"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["code"] = code;
    data["name"] = name;
    return data;
  }
}

class Category {
  String? id;
  String? name;
  String? image;
  int? likes;

  Category({this.id, this.name, this.image, this.likes});

  Category.fromJson(Map<String, dynamic> json) {
    if (json["_id"] is String) {
      id = json["_id"];
    }
    if (json["name"] is String) {
      name = json["name"];
    }
    if (json["image"] is String) {
      image = json["image"];
    }
    if (json["likes"] is int) {
      likes = json["likes"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["_id"] = id;
    data["name"] = name;
    data["image"] = image;
    data["likes"] = likes;
    return data;
  }
}
