import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/review.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:get/get.dart';

class ContentDetailsController extends GetxController {
  final ContentService _contentService;

  ContentDetailsController(this._contentService);

  final selectedTab = 0.obs;
  Content? content;
  final Rx<List<Review>> reviews = Rx(<Review>[]);

  void loadReviews(String id) async {
    try {
      var data = await _contentService.loadReview(id);

      if (data.isOk) {
        printInfo(info: 'Got Review');
        printInfo(info: data.body.toString());
        reviews(data.body);
      }
    } catch (e) {
      e.printError();
    }
  }
}
