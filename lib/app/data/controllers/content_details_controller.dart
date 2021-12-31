import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class ContentDetailsController extends GetxController {
  final ContentService _contentService;

  ContentDetailsController(this._contentService);

  final selectedTab = 0.obs;
  Content? content;

  void loadReviews() {
    try {} catch (e) {
      e.printError();
    }
  }
}
