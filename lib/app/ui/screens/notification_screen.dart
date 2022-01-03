import 'package:candella/app/data/controllers/notification_controller.dart';
import 'package:candella/app/data/models/notification.dart' as notify;
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.loadNotification();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TitleOnlyAppbar(title: 'Notifications'),
                Obx(
                  () => NotificationList(data: controller.notifications.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationList extends StatelessWidget {
  final List<notify.Notification> data;

  const NotificationList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (data.isEmpty)
        ? Center(
            child: Text('No Notifications'),
          )
        : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, idx) {
              notify.Notification notification = data[idx];
              return ListTile(
                title: Text(notification.type),
                subtitle: Text(notification.message),
                isThreeLine: true,
                leading: Icon(Ionicons.notifications),
              );
            },
          );
  }
}
