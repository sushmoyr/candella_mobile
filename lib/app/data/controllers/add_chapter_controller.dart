import 'package:candella/app/data/models/chapter.dart';
import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/services/chapter_service.dart';
import 'package:candella/app/services/file_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddChapterController extends GetxController {
  AddChapterController(this._chapterService);

  final ChapterService _chapterService;
  final FileService _fileService = Get.find();

  final TextEditingController chapterTitle = TextEditingController();
  final TextEditingController defaultChapterContent = TextEditingController();
  final RxList<ImageContentInputController> imageInputs = RxList();
  final RxList<String> comicInputs = RxList();
  final TextEditingController photoChapterDescription = TextEditingController();

  ChapterMode mode = ChapterMode.comic;
  final RxBool loading = RxBool(false);

  void addImagesPath(List<String> paths) {
    if (mode == ChapterMode.photography) {
      imageInputs.addAll(
        paths.map(
          (e) => ImageContentInputController(e),
        ),
      );
    } else if (mode == ChapterMode.comic) {
      comicInputs.addAll(paths);
    }
  }

  Future<Result> addChapter(String catId, String contentId) async {
    loading(true);
    if (mode == ChapterMode.photography) {
      return _addPhotoChapter(catId, contentId);
    } else if (mode == ChapterMode.comic) {
      return _addComicChapter(catId, contentId);
    } else {
      return _addOtherChapter(catId, contentId);
    }
  }

  Future<Result> _addPhotoChapter(String catId, String contentId) async {
    try {
      List<PhotoContent> images = [];

      for (ImageContentInputController imageController in imageInputs) {
        String uploadedImageLink =
            await _fileService.uploadImage(imageController.imageUrl, null);
        images.add(
          PhotoContent(
              imageUrl: uploadedImageLink,
              caption: imageController.caption.text),
        );
      }

      PhotographyChapterBody pBody = PhotographyChapterBody(
          images: images, description: photoChapterDescription.text);

      Map<String, dynamic> requestBody = {
        "category": catId,
        "contentId": contentId,
        "chapterName": chapterTitle.text,
        "body": pBody.toJson(),
      };

      var response = await _chapterService.addChapter(requestBody);
      loading(false);
      if (response.hasError) {
        return Future.error('error');
      }

      printInfo(info: response.body.toString());
      var body = response.body;
      return Result.withBody(
        status: true,
        message: body['message'],
        body: body['body'],
      );
    } catch (e) {
      loading(false);
      return Result(false, '');
    }
  }

  Future<Result> _addComicChapter(String catId, String contentId) async {
    try {
      printInfo(info: comicInputs.length.toString());
      List<String> images = [];

      for (String link in comicInputs) {
        String uploadedImageLink = await _fileService.uploadImage(link, null);
        images.add(uploadedImageLink);
        printInfo(
            info: 'uploaded ${images.length} of ${comicInputs.length} images.');
      }

      printInfo(info: images.toString());

      Map<String, dynamic> requestBody = {
        "category": catId,
        "contentId": contentId,
        "chapterName": chapterTitle.text,
        "body": ComicChapterBody(pages: images).toJson(),
      };

      var response = await _chapterService.addChapter(requestBody);
      loading(false);
      if (response.hasError) {
        return Future.error('error');
      }

      printInfo(info: response.body.toString());
      var body = response.body;
      return Result.withBody(
        status: true,
        message: body['message'],
        body: body['body'],
      );
    } catch (e) {
      loading(false);
      return Result(false, '');
    }
  }

  Future<Result> _addOtherChapter(String catId, String contentId) async {
    try {
      Map<String, dynamic> requestBody = {
        "category": catId,
        "contentId": contentId,
        "chapterName": chapterTitle.text,
        "body": DefaultChapterBody(defaultChapterContent.text).toJson(),
      };
      printInfo(info: requestBody.toString());
      var response = await _chapterService.addChapter(requestBody);

      if (response.hasError) {
        return Result(false, response.statusText.toString());
      }

      printInfo(info: response.body.toString());
      var body = response.body;
      loading(false);
      return Result.withBody(
        status: true,
        message: body['message'],
        body: body['body'],
      );
    } catch (e) {
      loading(false);
      return Result(false, '');
    }
  }
}

class ImageContentInputController {
  final String imageUrl;
  final TextEditingController caption;

  ImageContentInputController(String image)
      : imageUrl = image,
        caption = TextEditingController();
}
