import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/data/models/FeaturedContent/featured_content_model.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
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
                        child: Obx(() => Image.network(EndPoints.host +
                            controller.user.value.profileImage)),
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
              ),
              FeatureSlider(
                data: controller.featuredContents,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureSlider extends StatelessWidget {
  const FeatureSlider({
    Key? key,
    required this.data,
  }) : super(key: key);

  final RxList<FeaturedContent> data;

  @override
  Widget build(BuildContext context) {
    printInfo(info: data.toString());
    return Obx(
      () => CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayCurve: Curves.decelerate,
          aspectRatio: 1,
          disableCenter: true,
        ),
        items: data.map((element) {
          return Builder(builder: (context) {
            return FeaturedCard(
              content: element,
              onItemClicked: _handleItemClick,
            );
          });
        }).toList(),
      ),
    );
  }

  void _handleItemClick(FeaturedContent content) {
    printInfo(info: content.toRawJson());
  }
}

class FeaturedCard extends StatelessWidget {
  const FeaturedCard({
    Key? key,
    required this.content,
    required this.onItemClicked,
  }) : super(key: key);
  final FeaturedContent content;
  final Function(FeaturedContent) onItemClicked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(16),
        elevation: 8,
        child: InkWell(
          onTap: () {
            printInfo(info: 'clicked');
            onItemClicked(content);
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  EndPoints.host + content.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content.title,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            content.author.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            content.description,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('Category: ${content.category.name}')
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
