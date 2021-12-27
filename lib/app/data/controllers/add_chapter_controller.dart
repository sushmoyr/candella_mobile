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

  ChapterMode mode = ChapterMode.comic;

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
    if (mode == ChapterMode.photography) {
      return _addPhotoChapter(catId, contentId);
    } else if (mode == ChapterMode.comic) {
      return _addComicChapter(catId, contentId);
    } else {
      return _addOtherChapter(catId, contentId);
    }
  }

  Result _addPhotoChapter(String catId, String contentId) {
    return Result(false, 'message');
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
        "body": images,
      };

      var response = await _chapterService.addChapter(requestBody);

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
      return Result(false, '');
    }
  }

  Result _addOtherChapter(String catId, String contentId) {
    return Result(false, 'message');
  }
}

class ImageContentInputController {
  final String imageUrl;
  final TextEditingController caption;

  ImageContentInputController(String image)
      : imageUrl = image,
        caption = TextEditingController();
}
