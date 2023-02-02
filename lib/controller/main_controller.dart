import 'package:cb_stocks/data/model/category_response.dart';
import 'package:cb_stocks/data/model/colors_response.dart';
import 'package:cb_stocks/data/model/images_response.dart';
import 'package:cb_stocks/data/repository.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  var latestImageList = <SingleImagesItem>[].obs;
  var latestImageLoading = false.obs;
  void fetchLatestImage() {
    latestImageLoading.value = true;
    repository.fetchLatestImage().then((value) {
      var resp = ImagesResponse.fromJson(value.data);
      latestImageList.clear();
      latestImageList.addAll(resp.images);
    }).whenComplete(() {
      latestImageLoading.value = false;
    });
  }

  var colorsList = <TagColors>[].obs;
  var colorLoading = false.obs;

  void fetchColorsLists() {
    colorLoading.value = true;
    repository.fetchColors().then((value) {
      var resp = ColorsResponse.fromJson(value.data);
      colorsList.clear();
      colorsList.addAll(resp.colors);
    }).whenComplete(() => colorLoading.value = false);
  }

  var categoryList = <Category>[].obs;
  var categoryLoading = false.obs;

  void fetchCategoryLoading() {
    categoryLoading.value = true;
    repository.fetchCategory().then((value) {
      var resp = CategoryResponse.fromJson(value.data);
      categoryList.clear();
      categoryList.addAll(resp.categories);
    }).whenComplete(() => categoryLoading.value = false);
  }
}
