import 'package:candella/app/data/controllers/content_details_controller.dart';
import 'package:candella/app/data/models/User.dart';
import 'package:candella/app/data/models/content.dart';
import 'package:candella/app/data/models/genre.dart';
import 'package:candella/app/data/models/review.dart';
import 'package:candella/app/resources/constants/endpoints.dart';
import 'package:candella/app/resources/constants/typedefs.dart';
import 'package:candella/app/resources/routes/app_routes.dart';
import 'package:candella/app/services/prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ContentDetails extends GetView<ContentDetailsController> {
  ContentDetails({Key? key}) : super(key: key);

  final Content _content = Get.arguments['content'];

  @override
  ContentDetailsController get controller {
    var con = super.controller;
    con.updateView(_content);
    return con;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double toolBarHeight = _getToolbarHeight(_content.category, width);
    toolBarHeight.printInfo();

    controller.content = _content;
    controller.loadReviews(_content.id);

    TextTheme textTheme = Theme.of(context).textTheme;
    _content.toRawJson().printInfo();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: _getFab(),
        body: CustomScrollView(
          controller: controller.scrollController,
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
                          EndPoints.host + _content.author.profileImage,
                        ),
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
                  SizedBox(
                    height: 24,
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

  Widget? _getFab() {
    User currentUser = User.fromRawJson(Prefs.getCurrentUser()!);
    if (_content.author.id == currentUser.id) {
      return Obx(
        () => Visibility(
          child: FloatingActionButton.extended(
            icon: Icon(Ionicons.add),
            onPressed: () {
              Get.toNamed(Routes.addChapter, arguments: {
                "category": _content.category.id,
                "contentId": _content.id,
              });
            },
            label: Text('Add Chapter'),
          ),
          visible: controller.visibleFAB.value,
        ),
      );
    }
  }
}

class ChapterXReview extends GetView<ContentDetailsController> {
  const ChapterXReview({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return (index == 0)
        ? ChapterView()
        : Column(
            //TODO Test it
            children: [
              AddReviewWidget(),
              Obx(
                () => ReviewView(reviews: controller.reviews.value),
              ),
            ],
          );
  }
}

class AddReviewWidget extends GetView<ContentDetailsController> {
  const AddReviewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => TextFormField(
              enabled: !controller.loading.value,
              controller: controller.addReviewTextController,
              maxLines: null,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                labelText: 'Add Review',
              ),
            ),
          ),
        ),
        IconButton(
          onPressed: _onReviewButtonClick,
          icon: Icon(Ionicons.send_outline),
        ),
      ],
    );
  }

  void _onReviewButtonClick() async {
    var result = await controller.addReview(controller.content!.id);
    if (result.status) {
      Get.snackbar('Review', 'Review added successfully!!');
    } else {
      Get.snackbar('Review', 'Could not add Review. Try Again!!');
    }
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

      return _chapterList(value, context);
    } else {
      return _emptyWidget(context);
    }
  }

  Widget _chapterList(Content value, BuildContext context) {
    return ListView.builder(
      itemCount: value.chapters.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.chapter, parameters: {
              "chapterId": value.chapters[index].id,
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: (index == 0) ? 0 : 8),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Text(
                    (index + 1).toString() + '. ',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    value.chapters[index].chapterName,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
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

class ReviewView extends StatelessWidget {
  final List<Review>? reviews;

  const ReviewView({Key? key, required this.reviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    printInfo(info: reviews.toString());
    if (reviews != null) {
      if (reviews!.isEmpty) {
        return _emptyWidget(context);
      } else {
        var data = reviews!;
        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, idx) {
            return ReviewCard(review: data[idx]);
          },
        );
      }
    }
    return _emptyWidget(context);
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
            'No Reviews Added',
            style: Theme.of(context).textTheme.headline6,
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.review}) : super(key: key);
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: ClipOval(
              child: CircleAvatar(
                child: Image.network(
                  EndPoints.host + review.author.profileImage,
                ),
              ),
            ),
            title: Text(review.author.name),
            subtitle: Text(_getDateString(review.createdAt)),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Text(
              review.text,
              maxLines: null,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          )
        ],
      ),
    );
  }

  String _getDateString(DateTime createdAt) {
    DateTime currentDate = DateTime.now();

    var diff = currentDate.difference(createdAt);
    String result = 'Building';

    if (diff.inHours < 1) {
      if (diff.inMinutes < 1) {
        result = 'A few moments ago';
      } else {
        result = '${diff.inMinutes} minutes ago';
      }
    } else if (diff.inHours < 24) {
      result = '${diff.inHours} hours ago';
    } else {
      if (diff.inDays == 1) {
        result = '${diff.inDays} day ago';
      } else {
        result = '${diff.inDays} days ago';
      }
    }

    return result;
  }
}
