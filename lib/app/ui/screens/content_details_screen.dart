import 'package:candella/app/data/controllers/content_details_controller.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ContentDetails extends GetView<ContentDetailsController> {
  ContentDetails({Key? key}) : super(key: key);

  final Content _content = Get.arguments['content'];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double toolBarHeight = _getToolbarHeight(_content.category, width);
    toolBarHeight.printInfo();

    controller.content = _content;

    TextTheme textTheme = Theme.of(context).textTheme;
    _content.toRawJson().printInfo();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              collapsedHeight: toolBarHeight * 0.3,
              expandedHeight: toolBarHeight,
              backgroundColor: Colors.transparent,
              elevation: 0,
              flexibleSpace: SizedBox(
                width: width,
                height: toolBarHeight,
                child: Image.network(
                  EndPoints.host + _content.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Text(
                    _content.title,
                    style: textTheme.headline4,
                  ),
                  ..._getAlternateNames(_content.alternateNames, textTheme),
                  ListTile(
                    leading: ClipOval(
                      child: CircleAvatar(
                        child: Image.network(
                            EndPoints.host + _content.author.profileImage),
                      ),
                    ),
                    title: Text(
                      _content.author.name,
                      style: textTheme.subtitle1,
                    ),
                  ),
                  Text(
                    _content.category.name,
                    style: textTheme.overline,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    _content.description,
                    style: textTheme.bodyText1,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text('Posted on: ${_getDate(_content.createdAt)}'),
                  _getChips(_content.genre),
                  TabBar(
                    onTap: (index) {
                      index.printInfo();
                      controller.selectedTab.value = index;
                    },
                    tabs: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Chapters',
                          style: textTheme.subtitle1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Reviews',
                          style: textTheme.subtitle1,
                        ),
                      ),
                    ],
                  ),
                  Obx(
                    () => ChapterXReview(index: controller.selectedTab.value),
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getDate(String date) {
    var parsed = DateTime.tryParse(date);
    if (parsed != null) {
      var d = parsed;
      var string = '${d.day}/${d.month}/${d.year}';
      return string;
    }
    return date;
  }

  Widget _getChips(List<Genre> genres) {
    List<Widget> children = [Text('Genres:')];
    children.addAll(
      List.from(
        genres.map(
          (e) => Chip(
            label: Text(e.name),
          ),
        ),
      ),
    );
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8,
      runSpacing: 8,
      children: children,
    );
  }

  List<Widget> _getAlternateNames(List<String> names, TextTheme textTheme) {
    return (names.isNotEmpty)
        ? List.from(
            _content.alternateNames.map(
              (e) => Text(
                e,
                style: textTheme.overline,
              ),
            ),
          )
        : [Container()];
  }

  double _getToolbarHeight(Category category, double width) {
    double ratio;
    if (category.id == Category.journal.id ||
        category.id == Category.photography.id) {
      ratio = 3 / 2;
    } else {
      ratio = 2 / 3;
    }
    return (width / ratio);
  }
}

class ChapterXReview extends StatelessWidget {
  const ChapterXReview({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return (index == 0) ? ChapterView() : Text('See Review');
  }
}

class ChapterView extends GetView<ContentDetailsController> {
  const ChapterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _getWidget(context);
  }

  Widget _getWidget(BuildContext context) {
    if (controller.content != null) {
      var value = controller.content!;

      if (value.chapters.isEmpty) {
        return _emptyWidget(context);
      }

      return _chapterList(value);
    } else {
      return _emptyWidget(context);
    }
  }

  Widget _chapterList(Content value) {
    return ListView.builder(
      itemCount: value.chapters.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(value.chapters[index].chapterName),
        );
      },
    );
  }

  Widget _emptyWidget(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Ionicons.sad_outline,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'No Chapters Added',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class ReviewView extends GetView<ContentDetailsController> {
  const ReviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
