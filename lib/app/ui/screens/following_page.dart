import 'package:candella/app/data/controllers/following_controller.dart';
import 'package:candella/app/ui/widgets/follow_list.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class FollowingPage extends GetView<FollowingController> {
  const FollowingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String id = Get.arguments;

    controller.getFollowing(id);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                TitleOnlyAppbar(
                  title: 'Following',
                  trailing: AppIconButton(
                    onTap: () {
                      Get.back();
                    },
                    iconData: Ionicons.close,
                  ),
                ),
                Obx(
                  () => FollowList(data: controller.following.value),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
