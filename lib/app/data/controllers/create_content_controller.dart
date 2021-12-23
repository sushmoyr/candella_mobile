import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/data/models/request_models/content_request.dart';
import 'package:candella/app/data/models/result.dart';
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
  final Rx<String?> message = Rx(null);
  final RxList<Genre> addedGenres = RxList<Genre>();
  final RxList<Genre> genreData = RxList<Genre>();
  final RxList<String> alternateTitles = RxList();
  final RxString coverImage = RxString('');

  final ContentService _contentService;
  final FileService _fileService;
  String _status = '';

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

  Future<Result> postContent() async {
    loading(true);
    final String title = this.title.value.text;
    final String description = this.description.value.text;
    final List<String> genre = List.from(
      addedGenres.map((element) => element.id),
    );
    final String category = selectedCategory.value.id;
    String? coverImage;

    if (this.coverImage.value.isNotEmpty) {
      try {
        _status = 'Uploading Image';
        String uploadedImageLink = await _fileService.uploadImage(
            this.coverImage.value, _uploadProgress);
        coverImage = uploadedImageLink;
        print(uploadedImageLink);
      } catch (e) {
        coverImage = null;
      }
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
    _status = 'Uploading Post';
    final status = await _contentService.postContent(request.toJson(),
        progress: _uploadProgress);

    loading(false);
    if (status != null) {
      return Result(true, 'Metadata Added');
    } else {
      return Result(false, 'Something Went Wrong');
    }
  }

  void _uploadProgress(percentage) {
    message.value = '$_status $percentage%';
  }
}
