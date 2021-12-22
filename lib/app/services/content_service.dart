import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/data/models/interfaces/api_result.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/interceptors/get_modifiers.dart';

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

  void postContent(body) async {
    final String token = Prefs.getToken()!;
    /*final value = post(url, body,headers: {"token": token});
    print(value);*/
  }
}
