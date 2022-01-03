import 'package:candella/app/data/controllers/extras_controller.dart';
import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ExtrasScreen extends GetView<ExtrasController> {
  const ExtrasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rawUser = Prefs.getCurrentUser();
    if (rawUser == null) {
      return Container();
    }
    User user = User.fromRawJson(rawUser);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: CircleAvatar(
                    child: Image.network(EndPoints.host + user.profileImage),
                    radius: 64,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Wrap(
                  direction: Axis.vertical,
                  children: [
                    Text(
                      user.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    Text(user.email ?? '')
                  ],
                )
              ],
            ),
            Spacer(),
            ListTile(
              onTap: () {
                Get.offAllNamed(
                  Routes.auth,
                  predicate: (route) => Get.currentRoute == Routes.auth,
                );
                Prefs.destroyOnLogout();
              },
              leading: Icon(Ionicons.power_outline),
              title: Text('Log Out'),
            )
          ],
        ),
      )),
    );
  }
}
