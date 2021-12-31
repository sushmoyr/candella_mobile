import 'package:candella/app/data/models/chapter.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class ChapterController extends GetxController {
  final ContentService _service;

  ChapterController(this._service);

  final RxBool loading = RxBool(false);
  final Rx<Chapter?> currentChapter = Rx(null);

  void loadChapter(String chapterId) async {
    loading(true);
    var response = await _service.loadChapter(chapterId);
    loading(false);
    if (!response.hasError) {
      currentChapter(response.body);
    }
  }
}
