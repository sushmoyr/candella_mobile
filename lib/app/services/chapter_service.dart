import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';

class ChapterService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
    super.onInit();
  }

  //add chapter
  Future<Response> addChapter(body) {
    return post(EndPoints.chapter, body, headers: {"token": Prefs.getToken()!});
  }

//get single chapter

//get all chapters

//edit chapter

//delete chapter
}
