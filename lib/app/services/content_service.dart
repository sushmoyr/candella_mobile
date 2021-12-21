import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:get/get.dart';

class ContentService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
  }

  Future<Response<List<Genre>>> loadGenre(categoryId) {
    return get(
      '/${EndPoints.genres}/$categoryId',
      decoder: (json) => Genre.fromList(json),
    );
  }
}
