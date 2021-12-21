import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateContentController extends GetxController {
  final String value = 'hello world';
  late final TextEditingController title;
  late final List<TextEditingController> alternateNames;
  late final TextEditingController description;
  late final List<TextEditingController> tags;
  late final List<Category> categories;
  late final Rx<Category> selectedCategory;
  final RxBool loadingGenre = RxBool(false);
  final RxList<Genre> addedGenres = RxList<Genre>();
  final RxList<Genre> genreData = RxList<Genre>();

  final ContentService _contentService;

  CreateContentController(this._contentService);

  @override
  void onInit() {
    categories = Category.categoryData;
    selectedCategory = categories[0].obs;
    title = TextEditingController();
    description = TextEditingController();
    _loadGenreFromCategory();
    super.onInit();
  }

  void selectCategory(Category category) {
    selectedCategory.value = category;
    update();
    _loadGenreFromCategory();
  }

  void _loadGenreFromCategory() {
    loadingGenre(true);
    addedGenres([]);
    String categoryId = selectedCategory.value.id;
    print('Selected Category id = $categoryId');
    _contentService.loadGenre(categoryId).then((value) {
      if (value.hasError) {
        print(value.statusText.toString());
        return;
      }
      genreData(value.body);
      loadingGenre(false);
      print(value.body);
    });
  }
}
