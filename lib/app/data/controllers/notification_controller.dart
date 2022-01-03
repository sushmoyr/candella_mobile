import 'package:candella/app/data/models/notification.dart';
import 'package:candella/app/services/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationService _notificationService;

  NotificationController(this._notificationService);

  Rx<List<Notification>> notifications = Rx(<Notification>[]);

  void loadNotification() async {
    var response = await _notificationService.getNotification();

    if (!response.hasError) {
      notifications(response.body);
      response.body.printInfo();
      notifications.refresh();
    }
  }
}
