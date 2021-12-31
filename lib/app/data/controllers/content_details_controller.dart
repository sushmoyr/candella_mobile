import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/result.dart';
import 'package:candella/app/data/models/review.dart';
import 'package:candella/app/services/content_service.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class ContentDetailsController extends GetxController {
  final ContentService _contentService;

  ContentDetailsController(this._contentService);

  final ScrollController scrollController = ScrollController();

  final selectedTab = 0.obs;
  Content? content;
  final Rx<List<Review>> reviews = Rx(<Review>[]);
  final addReviewTextController = TextEditingController();
  final RxBool loading = RxBool(false);
  final RxBool visibleFAB = RxBool(true);
  bool viewUpdated = false;

  void updateView(Content content) {
    User currentUser = User.fromRawJson(Prefs.getCurrentUser()!);

    if (currentUser.id != content.author.id) {
      var id = content.id;
      if (!viewUpdated) {
        'Updating content of $id'.printInfo();
        _contentService.updateView(id);
        viewUpdated = true;
      }
    }
  }

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        visibleFAB(true);
      } else {
        visibleFAB(false);
      }
    });
    super.onInit();
  }

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

  Future<Result> addReview(String contentId) async {
    Map<String, dynamic> body = {
      "contentId": contentId,
      "text": addReviewTextController.text,
    };
    loading(true);
    var response = await _contentService.addReview(contentId, body);
    loading(false);
    if (response.isOk) {
      loadReviews(contentId);
      addReviewTextController.clear();
      return Result(true, '');
    }
    return Result(false, '');
  }

  @override
  void onClose() {
    addReviewTextController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
