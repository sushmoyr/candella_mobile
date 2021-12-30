import 'package:candella/app/data/controllers/visitor_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/ui/screens/error_page.dart';
import 'package:candella/app/ui/widgets/expandable_card.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/value_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class VisitorScreen extends GetView<VisitorController> {
  const VisitorScreen({Key? key}) : super(key: key);

  Widget _getBodyTree(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Image.network(
                    EndPoints.host + controller.user.value.coverImage,
                    loadingBuilder: (context, widget, loading) {
                      if (loading == null) {
                        return widget;
                      }
                      return Image.asset(StringRes.defaultCoverImage);
                    },
                  ),
                  SizedBox(
                    height: 64,
                  ),
                ],
              ),
              ClipOval(
                child: CircleAvatar(
                  child: Image.network(
                    EndPoints.host + controller.user.value.profileImage,
                    loadingBuilder: (context, child, loading) {
                      if (loading == null) {
                        return child;
                      }
                      return CircularProgressIndicator();
                    },
                  ),
                  radius: 64,
                ),
              )
            ],
          ),
          Text(
            controller.user.value.name,
            style: textTheme.headline5,
          ),
          Text(
            controller.user.value.penName ?? '',
            style: textTheme.overline,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              controller.user.value.bio ?? '',
              textAlign: TextAlign.center,
              style: textTheme.bodyText2,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ValueCard(
                  name: 'Followers',
                  value: controller.user.value.followers.length,
                ),
              ),
              Expanded(
                child: ValueCard(
                  name: 'Following',
                  value: controller.user.value.following.length,
                ),
              ),
              Expanded(
                child: Obx(() =>
                    FollowCard(isFollowing: controller.isFollowedByMe.value)),
              ),
            ],
          ),
          //About
          Align(
            alignment: Alignment.centerLeft,
            child: _getAboutView(context),
          ),
          Text('Posts'),
        ],
      ),
    );
  }

  Widget _getAboutView(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(16),
      child: ExpandableCard(
        title: 'About',
        titleStyle: textTheme.headline5,
        elevation: 4,
        radius: 36,
        children: [
          ListTile(
            leading: Icon(Ionicons.transgender),
            title: Text('Gender'),
            subtitle: Text(controller.user.value.gender),
          ),
          ListTile(
            leading: Icon(Ionicons.calendar_clear_outline),
            title: Text('Birthday'),
            subtitle: Text(controller.user.value.birthdate),
          ),
          ListTile(
            leading: Icon(Ionicons.mail_outline),
            title: Text('Email'),
            subtitle: Text(controller.user.value.email ?? ''),
          ),
          ListTile(
            leading: Icon(Ionicons.phone_portrait_outline),
            title: Text('Phone'),
            subtitle: Text(controller.user.value.phone ?? ''),
            style: ListTileStyle.list,
          ),
          ListTile(
            leading: Icon(Ionicons.location_outline),
            title: Text('Address'),
            subtitle: Text(controller.user.value.address ?? ''),
            style: ListTileStyle.list,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (Get.parameters['id'] != null) {
      controller.loadUser(Get.parameters['id']!).then((value) {
        if (!value.status) {
          printInfo(info: 'jump error');
          Get.off(() => ErrorScreen());
        }
      }).onError((error, stackTrace) {
        printInfo(info: 'To error');
        Get.off(() => ErrorScreen());
        throw error!;
      });
    } else {
      printInfo(info: 'why error');
      Get.off(() => ErrorScreen());
    }

    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.black.withAlpha(0),
      ),
      body: Obx(
        () => Loader(
          isLoading: controller.loading.value,
          child: _getBodyTree(context),
        ),
      ),
    );
  }
}

class FollowCard extends StatelessWidget {
  final bool isFollowing;
  final VoidCallback? onClick;

  const FollowCard({
    Key? key,
    required this.isFollowing,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (isFollowing)
        ? ValueCard(
            onClick: onClick,
            valueWidget: Icon(
              Ionicons.person_remove_outline,
              color: Theme.of(context).primaryColor,
            ),
            name: "Unfollow",
          )
        : ValueCard(
            onClick: onClick,
            valueWidget: Icon(Ionicons.person_add_outline),
            name: "Follow",
          );
  }
}
