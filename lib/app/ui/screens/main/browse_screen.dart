import 'package:candella/app/data/controllers/BrowseScreenController.dart';
import 'package:candella/app/data/models/content.dart';
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
                  ),
                ),
                Obx(
                  () => NovelSection(
                    data: controller.novelData.value,
                  ),
                ),
                Obx(
                  () => PoemSection(
                    data: controller.poemData.value,
                  ),
                ),
                Obx(
                  () => ComicSection(
                    data: controller.comicData.value,
                  ),
                ),
                Obx(
                  () => JournalSection(
                    data: controller.journalData.value,
                  ),
                ),
                Obx(
                  () => PhotographSection(
                    data: controller.photographData.value,
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

class StorySection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Story',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
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
                        onItemClick: () {
                          if (onContentClick != null) {
                            onContentClick!(element);
                          }
                        }),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class NovelSection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Novels',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
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
                        onItemClick: () {
                          if (onContentClick != null) {
                            onContentClick!(element);
                          }
                        }),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class PoemSection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Story',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
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
                        onItemClick: () {
                          if (onContentClick != null) {
                            onContentClick!(element);
                          }
                        }),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class ComicSection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Comic',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
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
                        onItemClick: () {
                          if (onContentClick != null) {
                            onContentClick!(element);
                          }
                        }),
                  ),
                ),
              )
            ],
          )
        : Container();
  }
}

class JournalSection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Journal',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LandscapeContentItemCard(
                    content: data[index],
                    onClick: () {
                      if (onContentClick != null) {
                        onContentClick!(data[index]);
                      }
                    },
                  );
                },
              )
            ],
          )
        : Container();
  }
}

class PhotographSection extends StatelessWidget {
  final VoidCallback? onSeeMore;
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
              SizedBox(
                height: 16,
              ),
              Text(
                'Photographs',
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              SizedBox(
                height: 16,
              ),
              ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return LandscapeContentItemCard(
                    content: data[index],
                    onClick: () {
                      if (onContentClick != null) {
                        onContentClick!(data[index]);
                      }
                    },
                  );
                },
              )
            ],
          )
        : Container();
  }
}
