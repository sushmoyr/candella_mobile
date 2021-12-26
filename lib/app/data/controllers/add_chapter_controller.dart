import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddChapterController extends GetxController {
  AddChapterController();

  final TextEditingController chapterTitle = TextEditingController();
  final TextEditingController defaultChapterContent = TextEditingController();
  final RxList<ImageContentInputController> imageInputs = RxList();
  final RxList<String> comicInputs = RxList();

  ChapterMode mode = ChapterMode.other;

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
}

class ImageContentInputController {
  final String imageUrl;
  final TextEditingController caption;

  ImageContentInputController(String image)
      : imageUrl = image,
        caption = TextEditingController();
}
