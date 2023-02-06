import 'package:cb_stocks/data/model/images_response.dart';
import 'package:cb_stocks/data/repository.dart';
import 'package:get/get.dart';

class StaggeredImageController extends GetxController {
  var staggeredImageLoading = false.obs;
  var staggeredImageList = <SingleImagesItem>[].obs;
  var hasMore = true.obs;

  Future<void> generalFetching(String categoryId, {int? pageNo}) async {
    staggeredImageLoading.value = true;
    hasMore.value = true;
    staggeredImageList.clear();
    await fetchStaggeredImage(categoryId, pageNo: 1);
    staggeredImageLoading.value = false;
  }

  Future<void> fetchStaggeredImage(String categoryId, {int? pageNo}) async {
    repository.fetchImageByCategory(categoryId, page: pageNo).then((value) {
      var resp = ImagesResponse.fromJson(value.data);
      if (resp.images.isEmpty || resp.images.length < 8) {
        hasMore.value = false;
      }
      if (resp.images.isNotEmpty) {
        staggeredImageList.addAll(resp.images);
      }
    });
  }

  Future<void> generalFetchColorImage(String categoryId, {int? pageNo}) async {
    staggeredImageLoading.value = true;
    hasMore.value = true;
    staggeredImageList.clear();
    await fetchFetchColorImage(categoryId, pageNo: 1);
    staggeredImageLoading.value = false;
  }

  Future<void> fetchFetchColorImage(String categoryId, {int? pageNo}) async {
    repository.fetchImageByColors(categoryId, page: pageNo).then((value) {
      var resp = ImagesResponse.fromJson(value.data);
      if (resp.images.isEmpty || resp.images.length < 8) {
        hasMore.value = false;
      }
      if (resp.images.isNotEmpty) {
        staggeredImageList.addAll(resp.images);
      }
    });
  }
}
