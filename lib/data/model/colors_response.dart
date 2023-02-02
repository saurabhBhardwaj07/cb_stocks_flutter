import 'package:cb_stocks/data/model/images_response.dart';

class ColorsResponse {
  bool? success;
  List<TagColors> colors = [];

  ColorsResponse({this.success, required this.colors});

  ColorsResponse.fromJson(Map<String, dynamic> json) {
    if (json["success"] is bool) {
      success = json["success"];
    }
    if (json["colors"] is List) {
      colors =
          (json["colors"] as List).map((e) => TagColors.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["success"] = success;
    data["colors"] = colors.map((e) => e.toJson()).toList();
    return data;
  }
}
