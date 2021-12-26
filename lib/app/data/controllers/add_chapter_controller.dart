import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddChapterController extends GetxController {
  AddChapterController();

  final TextEditingController chapterTitle = TextEditingController();
  final TextEditingController defaultChapterContent = TextEditingController();
  final RxList<ImageContentInputController> imageInputs = RxList();
}

class ImageContentInputController {
  final String imageUrl;
  final TextEditingController caption;

  ImageContentInputController(String image)
      : imageUrl = image,
        caption = TextEditingController();
}
