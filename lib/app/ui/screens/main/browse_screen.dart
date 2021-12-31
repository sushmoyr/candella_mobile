import 'package:candella/app/data/controllers/BrowseScreenController.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/ui/widgets/default_content_item_card.dart';
import 'package:candella/app/ui/widgets/landscape_content_item_card.dart';
import 'package:candella/app/ui/widgets/title_only_appbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BrowseScreen extends GetView<BrowseScreenController> {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 8,
            ),
            child: Column(
              children: [
                TitleOnlyAppbar(title: controller.name),
                Obx(
                  () => StorySection(
                    data: controller.storyData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
                Obx(
                  () => NovelSection(
                    data: controller.novelData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
                Obx(
                  () => PoemSection(
                    data: controller.poemData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
                Obx(
                  () => ComicSection(
                    data: controller.comicData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
                Obx(
                  () => JournalSection(
                    data: controller.journalData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
                Obx(
                  () => PhotographSection(
                    data: controller.photographData.value,
                    onSeeMore: _handleOnSeeMoreClicked,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleOnSeeMoreClicked(Category category) {
    printInfo(info: category.name);
    Get.toNamed(Routes.browseByCategory, arguments: category);
  }
}

class StorySection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const StorySection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Stories',
                onSeeAllClick: () {
                  onSeeMore!(Category.story);
                },
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 10,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                ),
                items: List.from(
                  data.map(
                    (element) => DefaultContentItemCard(
                      content: element,
                      onItemClick: onContentClick,
                    ),
                  ),
                ),
              ),
            ],
          )
        : Container();
  }
}

class NovelSection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const NovelSection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Novels',
                onSeeAllClick: () {
                  onSeeMore!(Category.novel);
                },
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 10,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                ),
                items: List.from(
                  data.map(
                    (element) => DefaultContentItemCard(
                        content: element, onItemClick: onContentClick),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class PoemSection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const PoemSection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Poems',
                onSeeAllClick: () {
                  onSeeMore!(Category.poem);
                },
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 10,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                ),
                items: List.from(
                  data.map(
                        (element) => DefaultContentItemCard(
                        content: element, onItemClick: onContentClick),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class ComicSection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const ComicSection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Comics',
                onSeeAllClick: () {
                  onSeeMore!(Category.comic);
                },
              ),
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 16 / 10,
                  enableInfiniteScroll: false,
                  viewportFraction: 1,
                ),
                items: List.from(
                  data.map(
                        (element) => DefaultContentItemCard(
                        content: element, onItemClick: onContentClick),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class JournalSection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const JournalSection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Journals',
                onSeeAllClick: () {
                  onSeeMore!(Category.journal);
                },
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LandscapeContentItemCard(
                    content: data[index],
                    onClick: onContentClick,
                  );
                },
              )
            ],
          )
        : Container();
  }
}

class PhotographSection extends StatelessWidget {
  final Function(Category)? onSeeMore;
  final Function(Content)? onContentClick;

  const PhotographSection({
    Key? key,
    required this.data,
    this.onSeeMore,
    this.onContentClick,
  }) : super(key: key);
  final List<Content> data;

  @override
  Widget build(BuildContext context) {
    return (data.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithSeeAll(
                title: 'Photographs',
                onSeeAllClick: () {
                  onSeeMore!(Category.photography);
                },
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LandscapeContentItemCard(
                    content: data[index],
                    onClick: onContentClick,
                  );
                },
              )
            ],
          )
        : Container();
  }
}

class TitleWithSeeAll extends StatelessWidget {
  const TitleWithSeeAll({
    Key? key,
    required this.title,
    this.titleTextStyle,
    this.onSeeAllClick,
    this.seeAllTextStyle,
  }) : super(key: key);

  final String title;
  final TextStyle? titleTextStyle;
  final VoidCallback? onSeeAllClick;
  final TextStyle? seeAllTextStyle;

  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = Theme.of(context)
        .textTheme
        .headline5!
        .copyWith(color: Theme.of(context).primaryColor);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: titleTextStyle ?? defaultStyle,
          ),
          TextButton(
            onPressed: onSeeAllClick ?? () {},
            child: Text('See More'),
          ),
        ],
      ),
    );
  }
}
