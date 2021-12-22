import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //App bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(
                    () => Text(
                      'Hi, ${controller.user.value.name.split(' ').last}',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Wrap(
                    children: [
                      AppIconButton(
                        onTap: () {},
                        iconData: Ionicons.notifications_outline,
                      ),
                      AppIconButton(
                        onTap: () {
                          Get.toNamed(Routes.extras, arguments: {
                            "user": controller.user.value.toRawJson()
                          });
                        },
                        iconData: Ionicons.menu_outline,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 32,
              ),
              //Content post bar
              Row(
                children: [
                  ClipOval(
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.profile);
                        },
                        child: Obx(() =>
                            Image.network(controller.user.value.profileImage)),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(
                      child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.createContent);
                    },
                    child: Container(
                      height: 60,
                      child: Text(StringRes.writeSomething),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 24),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                              color: Theme.of(context).colorScheme.onSurface)),
                    ),
                  ))
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                'Featured',
                style: Theme.of(context).textTheme.headline5,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  const FeatureCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
