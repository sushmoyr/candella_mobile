import 'package:candella/app/data/models/notification.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:get/get.dart';

class NotificationService extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = EndPoints.baseUrl;
  }

  Future<Response<List<Notification>>> getNotification() {
    String token = Prefs.getToken()!;
    return get(
      EndPoints.notification,
      headers: {
        "token": token,
      },
      decoder: (json) => Notification.fromList(json),
    );
  }
}
