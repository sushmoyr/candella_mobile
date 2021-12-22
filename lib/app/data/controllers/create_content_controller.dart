import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/data/models/request_models/content_request.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CreateContentController extends GetxController {
  late final TextEditingController title;
  late final TextEditingController description;
  late final TextEditingController alternateTextField;
  late final TextEditingController tagsTextField;
  late final List<Category> categories;
  late final Rx<Category> selectedCategory;
  final RxBool loadingGenre = RxBool(false);
  final RxBool loading = RxBool(false);
  final RxList<Genre> addedGenres = RxList<Genre>();
  final RxList<Genre> genreData = RxList<Genre>();
  final RxList<String> alternateTitles = RxList();
  final RxString coverImage = RxString('');

  final ContentService _contentService;
  final FileService _fileService;

  CreateContentController(this._contentService, this._fileService);

  @override
  void onInit() {
    categories = Category.categoryData;
    selectedCategory = categories[0].obs;
    title = TextEditingController();
    description = TextEditingController();
    alternateTextField = TextEditingController();
    tagsTextField = TextEditingController();
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

  void _resetAlternateField() {
    alternateTextField.clear();
  }

  void addAlternateTitle(String title) {
    alternateTitles.add(title);
    _resetAlternateField();
  }

  void postContent() async {
    loading(true);
    final String title = this.title.value.text;
    final String description = this.description.value.text;
    final List<String> genre = List.from(
      addedGenres.map((element) => element.id),
    );
    final String category = selectedCategory.value.id;
    final coverImage =
        (this.coverImage.value.isNotEmpty) ? this.coverImage.value : null;

    print("File url = ${this.coverImage.value}");
    try {
      await _fileService.uploadImage(this.coverImage.value);
    } catch (e) {
      print(e.toString());
    }

    List<String>? tags;
    if (tagsTextField.value.text.isNotEmpty) {
      tags = tagsTextField.value.text.split(' ');
    }

    final alternateNames =
        (alternateTitles.isNotEmpty) ? alternateTitles.toList() : null;

    ContentRequest request = ContentRequest(
      title: title,
      description: description,
      genre: genre,
      category: category,
      alternateNames: alternateNames,
      tags: tags,
      coverImage: coverImage,
    );

    _contentService.postContent(request.toJson());
    loading(false);
  }
}
