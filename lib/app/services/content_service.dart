import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/data/models/review.dart';
import 'package:candella/app/data/models/success.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/services/prefs.dart';
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

  Future<Success?> postContent(body, {Function(double)? progress}) async {
    final String token = Prefs.getToken()!;
    print(body);

    try {
      final value = await post(
        EndPoints.content,
        body,
        headers: {"token": token},
        decoder: (obj) => Success.fromJson(obj),
        uploadProgress: progress,
      );

      if (value.hasError) {
        print(value.statusCode);
        print(value.body!.message);
        return null;
      }
      return value.body;
    } catch (e) {
      return null;
    }
  }

  Future<Response<List<Content>>> loadFeaturedPosts() {
    return get(
      EndPoints.featured,
      decoder: (json) => Content.fromList(json),
    );
  }

  Future<Response<List<Content>>> loadLatestPosts() {
    return get(
      EndPoints.content,
      decoder: (json) => Content.fromList(json),
    );
  }

  Future<Response<List<Content>>> loadPostByCategory(String catId) async {
    printInfo(info: 'Loading cat post');
    return get(
      EndPoints.content,
      query: {
        "category": catId,
      },
      decoder: (json) => Content.fromList(json),
    );
  }

  Future<Response<List<Review>>> loadReview(String id, {page = 1}) {
    return get(
      EndPoints.reviews + '/$id',
      decoder: (json) => Review.fromList(json),
    );
  }

  Future<Response<dynamic>> addReview(String contentId, body) {
    final String token = Prefs.getToken()!;
    return post(
      EndPoints.review,
      body,
      headers: {
        "token": token,
      },
    );
  }
}
