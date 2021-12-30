import 'package:candella/app/data/controllers/home_screen_controller.dart';
import 'package:candella/app/data/models/FeaturedContent/featured_content_model.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/app_strings.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/default_content_item_card.dart';
import 'package:candella/app/ui/widgets/feature_card.dart';
import 'package:candella/app/ui/widgets/landscape_content_item_card.dart';
import 'package:candella/app/ui/widgets/rounded_icon_button.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
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
                                color:
                                    Theme.of(context).colorScheme.onSurface)),
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
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Latest Releases',
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: 16,
                ),
                Obx(
                  () => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.latestContents.length,
                    itemBuilder: (context, index) {
                      Content data = controller.latestContents[index];
                      if (data.category.id == Category.journal.id ||
                          data.category.id == Category.photography.id) {
                        return LandscapeContentItemCard(
                          content: data,
                          onClick: () {},
                          elevation: 4,
                        );
                      } else {
                        return DefaultContentItemCard(
                          content: data,
                          onItemClick: () {},
                          elevation: 4,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
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
        items: List.from(
          data.map(
            (element) =>
                FeaturedCard(content: element, onItemClicked: _handleItemClick),
          ),
        ),
      ),
    );
  }

  void _handleItemClick(FeaturedContent content) {
    printInfo(info: content.toRawJson());
  }
}
