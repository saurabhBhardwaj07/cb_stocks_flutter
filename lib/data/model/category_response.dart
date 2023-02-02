import 'package:cb_stocks/data/model/images_response.dart';

class CategoryResponse {
  bool? success;
  List<Category> categories = [];

  CategoryResponse({this.success, required this.categories});

  CategoryResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["categories"] is List) {
      categories = (json["categories"] as List)
          .map((e) => Category.fromJson(e))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["categories"] = categories.map((e) => e.toJson()).toList();

    return data;
  }
}
