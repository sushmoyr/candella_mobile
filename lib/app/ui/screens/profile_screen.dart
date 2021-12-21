import 'package:candella/app/data/controllers/profile_screen_controller.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/ui/widgets/expandable_card.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:candella/app/ui/widgets/value_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({Key? key}) : super(key: key);

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
                    controller.user.value.coverImage,
                    loadingBuilder: (context, widget, loading) {
                      if (loading == null) {
                        return widget;
                      }
                      return Image.network(
                          StringRes.defaultCoverImage); //TODO: Add asset image
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
                    controller.user.value.profileImage,
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
                  value: controller.user.value.totalFollowers,
                ),
              ),
              Expanded(
                child: ValueCard(
                  name: 'Following',
                  value: controller.user.value.totalFollowing,
                ),
              ),
              Expanded(
                child: (controller.profileType == ProfileType.self)
                    ? ValueCard(
                        valueWidget: Icon(Ionicons.person_add_outline),
                        name: "Follow",
                      )
                    : AppIconButton(
                        iconSize: 36,
                        iconData: Ionicons.ellipsis_horizontal_circle_outline,
                        onTap: () {
                          print('more tapped');
                        },
                      ),
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
            subtitle: Text(controller.user.value.email!),
          ),
          ListTile(
            leading: Icon(Ionicons.phone_portrait_outline),
            title: Text('Phone'),
            subtitle: Text(controller.user.value.phone!),
            style: ListTileStyle.list,
          ),
          ListTile(
            leading: Icon(Ionicons.location_outline),
            title: Text('Address'),
            subtitle: Text(controller.user.value.address!),
            style: ListTileStyle.list,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller.loadUser(Get.parameters['id']);
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Colors.black.withAlpha(0),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
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
