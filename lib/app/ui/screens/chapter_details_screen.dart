import 'package:candella/app/data/controllers/chapter_details_controller.dart';
import 'package:candella/app/data/models/chapter.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/ui/screens/error_page.dart';
import 'package:candella/app/ui/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChapterDetailsScreen extends GetView<ChapterController> {
  const ChapterDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? chapterId = Get.parameters['chapterId'];

    if (chapterId == null) {
      Get.to(() => ErrorScreen());
    } else {
      controller.loadChapter(chapterId);
    }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
          () => Loader(
            isLoading: controller.loading.value,
            child: _getBody(context),
          ),
        ),
      ),
    ));
  }

  Widget _getBody(BuildContext context) {
    return Obx(
      () => ChapterBodyWidget(
        chapter: controller.currentChapter.value,
      ),
    );
  }
}

class ChapterBodyWidget extends StatelessWidget {
  final Chapter? chapter;

  const ChapterBodyWidget({Key? key, required this.chapter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (chapter == null) {
      return Center(
        child: ErrorScreen(),
      );
    } else {
      var chapterBody = chapter!.body;

      if (chapterBody is PhotographyChapterBody) {
        return _getPhotographyChapterBody(context, chapter!, chapterBody);
      } else if (chapterBody is ComicChapterBody) {
        return _getComicChapterBody(context, chapter!, chapterBody);
      } else {
        return _defaultChapterBody(
            context, chapter!, chapterBody as DefaultChapterBody);
      }
    }
  }

  Widget _defaultChapterBody(
      BuildContext context, Chapter chapter, DefaultChapterBody chapterBody) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Text(
            chapter.chapterName,
            style: Theme.of(context).textTheme.headline5,
          ),
          Text(
            chapterBody.data,
            softWrap: true,
          )
        ],
      ),
    );
  }

  Widget _getComicChapterBody(
      BuildContext context, Chapter chapter, ComicChapterBody chapterBody) {
    return SingleChildScrollView(
      child: Column(
        children: List.from(
          chapterBody.pages.map(
            (e) => Image.network(
              EndPoints.host + e,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }

  Widget _getPhotographyChapterBody(BuildContext context, Chapter chapter,
      PhotographyChapterBody chapterBody) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chapter.chapterName,
                softWrap: true,
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                chapterBody.description,
                style: Theme.of(context).textTheme.bodyText1,
                softWrap: true,
              ),
              ...List.from(
                chapterBody.images.map(
                  (e) => PhotoItem(
                    content: e,
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

class PhotoItem extends StatelessWidget {
  final PhotoContent content;

  const PhotoItem({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          Image.network(
            EndPoints.host + content.imageUrl,
            fit: BoxFit.fitWidth,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              content.caption,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
        ],
      ),
    );
  }
}
